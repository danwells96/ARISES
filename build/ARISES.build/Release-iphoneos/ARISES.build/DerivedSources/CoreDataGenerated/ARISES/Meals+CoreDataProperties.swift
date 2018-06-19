//
//  Meals+CoreDataProperties.swift
//  
//
//  Created by Ryan Armiger on 19/06/2018.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Meals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meals> {
        return NSFetchRequest<Meals>(entityName: "Meals")
    }

    @NSManaged public var carbs: Int32
    @NSManaged public var fat: Int32
    @NSManaged public var name: String?
    @NSManaged public var protein: Int32
    @NSManaged public var time: String?
    @NSManaged public var day: Day?
    @NSManaged public var favourite: Favourites?

}
