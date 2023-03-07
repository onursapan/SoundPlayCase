//
//  DataProvider.swift
//  SoundPlayCase
//
//  Created by Onur Sapan on 3/7/23.
//

import Foundation
import CoreData

class DataProvider {
    
    private let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    public func fetchSounds(pageLimit: Int, errorHandler: @escaping ((Error?)->Void)){
        let url = URL(string: "https://itunes.apple.com/search?term=jack+johnson&limit=\(40)&offset=0")!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                errorHandler(error)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(Artist.self, from: data)
                let taskContext = self.persistentContainer.newBackgroundContext()
                taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                taskContext.undoManager = nil
                
                _ = self.syncSounds(results: response.results ?? [], taskContext: taskContext)
                
                errorHandler(nil)
            } catch {
                errorHandler(error)
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    private func syncSounds(results: [Result], taskContext: NSManagedObjectContext) -> Bool {
        var successfull = false
        
        taskContext.performAndWait {
            let matchingSoundRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SoundPlay")
            let soundIds = results.map { $0.trackId }
            matchingSoundRequest.predicate = NSPredicate(format: "trackId in %@", argumentArray: [soundIds])
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: matchingSoundRequest)
            batchDeleteRequest.resultType = .resultTypeObjectIDs
            
            // Execute the request to de batch delete and merge the changes to viewContext, which triggers the UI update
            do {
                let batchDeleteResult = try taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult
                
                if let deletedObjectIDs = batchDeleteResult?.result as? [NSManagedObjectID] {
                    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedObjectIDs],
                                                        into: [self.persistentContainer.viewContext])
                }
            } catch {
                print("Error: \(error)\nCould not batch delete existing records.")
                return
            }
            
            // Create new records.
            for result in results {
                
                guard let sound = NSEntityDescription.insertNewObject(forEntityName: "SoundPlay", into: taskContext) as? SoundPlay else {
                    print("Error: Failed to create a new sound object!")
                    return
                }
                
                sound.update(model: result)
            }
            
            // Save all the changes just made and reset the taskContext to free the cache.
            if taskContext.hasChanges {
                do {
                    try taskContext.save()
                } catch {
                    print("Error: \(error)\nCould not save Core Data context.")
                }
                taskContext.reset() // Reset the context to clean up the cache and low the memory footprint.
            }
            successfull = true
        }

        return successfull
    }
}
