//
//  Glucose+CoreDataProperties.swift
//  
//
//  Created by Ryan Armiger on 19/06/2018.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Glucose {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Glucose> {
        return NSFetchRequest<Glucose>(entityName: "Glucose")
    }

    @NSManaged public var time: String?
    @NSManaged public var value: Double
    @NSManaged public var day: Day?

}
