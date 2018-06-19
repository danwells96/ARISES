//
//  Favourites+CoreDataProperties.swift
//  
//
//  Created by Ryan Armiger on 19/06/2018.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Favourites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourites> {
        return NSFetchRequest<Favourites>(entityName: "Favourites")
    }

    @NSManaged public var days: NSSet?
    @NSManaged public var exercise: NSSet?
    @NSManaged public var meals: NSSet?

}

// MARK: Generated accessors for days
extension Favourites {

    @objc(addDaysObject:)
    @NSManaged public func addToDays(_ value: Day)

    @objc(removeDaysObject:)
    @NSManaged public func removeFromDays(_ value: Day)

    @objc(addDays:)
    @NSManaged public func addToDays(_ values: NSSet)

    @objc(removeDays:)
    @NSManaged public func removeFromDays(_ values: NSSet)

}

// MARK: Generated accessors for exercise
extension Favourites {

    @objc(addExerciseObject:)
    @NSManaged public func addToExercise(_ value: Exercise)

    @objc(removeExerciseObject:)
    @NSManaged public func removeFromExercise(_ value: Exercise)

    @objc(addExercise:)
    @NSManaged public func addToExercise(_ values: NSSet)

    @objc(removeExercise:)
    @NSManaged public func removeFromExercise(_ values: NSSet)

}

// MARK: Generated accessors for meals
extension Favourites {

    @objc(addMealsObject:)
    @NSManaged public func addToMeals(_ value: Meals)

    @objc(removeMealsObject:)
    @NSManaged public func removeFromMeals(_ value: Meals)

    @objc(addMeals:)
    @NSManaged public func addToMeals(_ values: NSSet)

    @objc(removeMeals:)
    @NSManaged public func removeFromMeals(_ values: NSSet)

}
