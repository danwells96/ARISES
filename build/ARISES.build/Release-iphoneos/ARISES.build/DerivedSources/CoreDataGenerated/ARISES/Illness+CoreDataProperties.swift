//
//  Illness+CoreDataProperties.swift
//  
//
//  Created by Ryan Armiger on 19/06/2018.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Illness {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Illness> {
        return NSFetchRequest<Illness>(entityName: "Illness")
    }

    @NSManaged public var end: Date?
    @NSManaged public var start: Date?
    @NSManaged public var day: Day?

}
