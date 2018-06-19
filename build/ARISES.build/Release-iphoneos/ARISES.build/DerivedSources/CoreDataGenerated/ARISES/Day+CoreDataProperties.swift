//
//  Day+CoreDataProperties.swift
//  
//
//  Created by Ryan Armiger on 19/06/2018.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Day {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day")
    }

    @NSManaged public var date: String?
    @NSManaged public var exercise: NSSet?
    @NSManaged public var favourite: Favourites?
    @NSManaged public var glucose: NSSet?
    @NSManaged public var illness: NSSet?
    @NSManaged public var insulin: NSSet?
    @NSManaged public var meals: NSSet?
    @NSManaged public var stress: NSSet?

}

// MARK: Generated accessors for exercise
extension Day {

    @objc(addExerciseObject:)
    @NSManaged public func addToExercise(_ value: Exercise)

    @objc(removeExerciseObject:)
    @NSManaged public func removeFromExercise(_ value: Exercise)

    @objc(addExercise:)
    @NSManaged public func addToExercise(_ values: NSSet)

    @objc(removeExercise:)
    @NSManaged public func removeFromExercise(_ values: NSSet)

}

// MARK: Generated accessors for glucose
extension Day {

    @objc(addGlucoseObject:)
    @NSManaged public func addToGlucose(_ value: Glucose)

    @objc(removeGlucoseObject:)
    @NSManaged public func removeFromGlucose(_ value: Glucose)

    @objc(addGlucose:)
    @NSManaged public func addToGlucose(_ values: NSSet)

    @objc(removeGlucose:)
    @NSManaged public func removeFromGlucose(_ values: NSSet)

}

// MARK: Generated accessors for illness
extension Day {

    @objc(addIllnessObject:)
    @NSManaged public func addToIllness(_ value: Illness)

    @objc(removeIllnessObject:)
    @NSManaged public func removeFromIllness(_ value: Illness)

    @objc(addIllness:)
    @NSManaged public func addToIllness(_ values: NSSet)

    @objc(removeIllness:)
    @NSManaged public func removeFromIllness(_ values: NSSet)

}

// MARK: Generated accessors for insulin
extension Day {

    @objc(addInsulinObject:)
    @NSManaged public func addToInsulin(_ value: Insulin)

    @objc(removeInsulinObject:)
    @NSManaged public func removeFromInsulin(_ value: Insulin)

    @objc(addInsulin:)
    @NSManaged public func addToInsulin(_ values: NSSet)

    @objc(removeInsulin:)
    @NSManaged public func removeFromInsulin(_ values: NSSet)

}

// MARK: Generated accessors for meals
extension Day {

    @objc(addMealsObject:)
    @NSManaged public func addToMeals(_ value: Meals)

    @objc(removeMealsObject:)
    @NSManaged public func removeFromMeals(_ value: Meals)

    @objc(addMeals:)
    @NSManaged public func addToMeals(_ values: NSSet)

    @objc(removeMeals:)
    @NSManaged public func removeFromMeals(_ values: NSSet)

}

// MARK: Generated accessors for stress
extension Day {

    @objc(addStressObject:)
    @NSManaged public func addToStress(_ value: Stress)

    @objc(removeStressObject:)
    @NSManaged public func removeFromStress(_ value: Stress)

    @objc(addStress:)
    @NSManaged public func addToStress(_ values: NSSet)

    @objc(removeStress:)
    @NSManaged public func removeFromStress(_ values: NSSet)

}
