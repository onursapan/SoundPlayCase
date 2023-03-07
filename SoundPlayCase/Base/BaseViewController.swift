//
//  BaseViewController.swift
//  SoundPlayCase
//
//  Created by Onur Sapan on 3/8/23.
//

import Foundation
import UIKit
import CoreData

class BaseViewController<T: BaseViewModel>: UIViewController, NSFetchedResultsControllerDelegate{
    
    var viewModel: T?
    
    lazy var fetchedResultsController: NSFetchedResultsController<SoundPlay> = {
        guard let viewModel = viewModel else{
            fatalError("ViewModel is not implemented!")
        }
        let fetchRequest = NSFetchRequest<SoundPlay>(entityName:"SoundPlay")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "trackId", ascending:true)]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: viewModel.dataProvider.viewContext,
                                                    sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        
        do {
            try controller.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return controller
    }()
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        onDataChanged()
    }
    
    func onDataChanged(){}
}
