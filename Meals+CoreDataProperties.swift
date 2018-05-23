//
//  Meals+CoreDataProperties.swift
//  ARISES
//
//  Created by Ryan Armiger on 22/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//
//

import Foundation
import CoreData


extension Meals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meals> {
        return NSFetchRequest<Meals>(entityName: "Meals")
    }

    @NSManaged public var name: String?
    @NSManaged public var time: String?
    @NSManaged public var carbs: Int32
    @NSManaged public var protein: Int32
    @NSManaged public var fat: Int32

}
