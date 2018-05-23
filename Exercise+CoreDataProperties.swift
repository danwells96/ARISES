//
//  Exercise+CoreDataProperties.swift
//  ARISES
//
//  Created by Ryan Armiger on 23/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var name: String?
    @NSManaged public var time: String?
    @NSManaged public var duration: String?
    @NSManaged public var intensity: String?

}
