//
//  SoundPlay+CoreDataProperties.swift
//  SoundPlayCase
//
//  Created by Onur Sapan on 3/7/23.
//
//

import Foundation
import CoreData


extension SoundPlay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SoundPlay> {
        return NSFetchRequest<SoundPlay>(entityName: "SoundPlay")
    }

    @NSManaged public var artisName: String?
    @NSManaged public var albumImage: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var resultCount: Int32
    @NSManaged public var trackName: String?

}

extension SoundPlay : Identifiable {

}
