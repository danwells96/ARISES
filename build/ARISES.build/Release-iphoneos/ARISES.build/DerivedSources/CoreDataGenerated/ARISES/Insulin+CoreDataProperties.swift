//
//  Insulin+CoreDataProperties.swift
//  
//
//  Created by Ryan Armiger on 19/06/2018.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Insulin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Insulin> {
        return NSFetchRequest<Insulin>(entityName: "Insulin")
    }

    @NSManaged public var time: String?
    @NSManaged public var units: Double
    @NSManaged public var day: Day?

}
