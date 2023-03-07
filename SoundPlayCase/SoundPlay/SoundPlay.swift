//
//  SoundPlay.swift
//  SoundPlayCase
//
//  Created by Onur Sapan on 3/7/23.
//

import Foundation
import CoreData

@objc(SoundPlay)
class SoundPlay: NSManagedObject{
    
    @NSManaged var albumImage: String?
    @NSManaged var artistName: String?
    @NSManaged var trackName: String?
    @NSManaged var releaseDate: String?
    @NSManaged var trackId: NSNumber?
    
    func update(model: Result){
        albumImage = model.artworkUrl100
        artistName = model.artistName
        trackName = model.trackName
        releaseDate = model.releaseDate
        if let id = model.trackId{
            trackId = NSNumber.init(integerLiteral: id)
        }
    }
}
