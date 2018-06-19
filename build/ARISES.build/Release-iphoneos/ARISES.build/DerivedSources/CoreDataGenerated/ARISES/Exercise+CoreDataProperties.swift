//
//  Exercise+CoreDataProperties.swift
//  
//
//  Created by Ryan Armiger on 19/06/2018.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var duration: String?
    @NSManaged public var intensity: String?
    @NSManaged public var name: String?
    @NSManaged public var time: String?
    @NSManaged public var day: Day?
    @NSManaged public var favourite: Favourites?

}
