//
//  ModelController.swift
//  ARISES
//
//  Created by Ryan Armiger on 25/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import Foundation
import CoreData

class ModelController {

    //TODO: - To Do List
    //TODO: Fetch requests require sorting. Short times currently sort incorrectly
    //TODO: Abstract functions to apply to food, exercise and days etc.
    //TODO: Test and validate/tighten up corner cases for data values
    //TODO: Ensure optionals never cause exceptions e.g. with Guard
    
    
    //MARK: - Basic date formatting functions
    func formatDateToDay(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    func formatDateToTime(date: Date) -> String{
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        return timeFormatter.string(from: date)
    }
    func formatDateToHHmm(date: Date) -> String{
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        return timeFormatter.string(from: date)
    }
    
    //MARK: - Private functions
    private func checkForExistingFavourites() -> Favourites{
        let favFetch: NSFetchRequest<Favourites> = Favourites.fetchRequest()
        let checkFav = try? PersistenceService.context.fetch(favFetch)
        if checkFav != nil{
            if checkFav?.count != 0{
                return checkFav![0]
                }
            else{
                let newFav = Favourites(context: PersistenceService.context)
                PersistenceService.saveContext()
                return newFav
            }
        }
        print("Error fetching favourites")
        return checkFav![0]
    }

    private func findOrMakeDay(day: Date) -> Day{
        let day = formatDateToDay(date: day)
        //predicate date
        let dateFetch: NSFetchRequest<Day> = Day.fetchRequest()
       dateFetch.predicate = NSPredicate(format: "date == %@", day)
        let checkForDay = try? PersistenceService.context.fetch(dateFetch)
        if checkForDay != nil{
            if checkForDay?.count != 0{
                return (checkForDay!.first!)
            }
            else{
                let newDay = Day(context: PersistenceService.context)
                newDay.date = day
                PersistenceService.saveContext()
                return newDay
            }
        }
        print("Error finding or creating day log")
        return checkForDay![0]
        //Should never happen and will almost certainly crash if it does
    }
    //MARK: - Data object setting (add/toggle)
    func addMeal(name: String, time: String, date: Date, carbs: Int32, fat: Int32, protein: Int32){
        
        let currentDay = findOrMakeDay(day: date)
        let newMeal = Meals(context: PersistenceService.context)
        newMeal.name = name
        newMeal.time = time
        newMeal.carbs = carbs
        newMeal.protein = protein
        newMeal.fat = fat
        currentDay.addToMeals(newMeal)
        PersistenceService.saveContext()
    }
    
    func addExercise(name: String, time: String, date: Date, intensity: String, duration: String){
        
        let currentDay = findOrMakeDay(day: date)
        let newExercise = Exercise(context: PersistenceService.context)
        newExercise.name = name
        newExercise.time = time
        newExercise.intensity = intensity
        newExercise.duration = duration
        currentDay.addToExercise(newExercise)
        PersistenceService.saveContext()
    }
    
    func addGlucose(value: Double, time: String, date: Date){
        
        let currentDay = findOrMakeDay(day: date)
        let newGlucose = Glucose(context: PersistenceService.context)
        newGlucose.value = value
        newGlucose.time = time
        currentDay.addToGlucose(newGlucose)
        PersistenceService.saveContext()
    }
    
    func addInslin(units: Double, time: String, date: Date){
        
        let currentDay = findOrMakeDay(day: date)
        let newInsulin = Insulin(context: PersistenceService.context)
        newInsulin.units = units
        newInsulin.time = time
        currentDay.addToInsulin(newInsulin)
        PersistenceService.saveContext()
    }
    
    
    //MARK: - Data object getting (fetch/return)
    //Only toggles meals currently
    func toggleFavourite(item: Meals){
        
        let favList = checkForExistingFavourites()
        var found = false
        for index in favList.objectIDs(forRelationshipNamed: "meals"){
            if index == item.objectID{
                favList.removeFromMeals(item)
                found = true
            }
        }
        if found == false{
            favList.addToMeals(item)
        }
        PersistenceService.saveContext()
    }
    
    //Returns true if item is favourites - currently only meals
    func itemInFavourites(item: Meals) -> Bool{
        
        let favList = checkForExistingFavourites()
        for index in favList.objectIDs(forRelationshipNamed: "meals"){
            if index == item.objectID{
                return true
            }
        }
        return false
    }
    
    //Currently only fetches meals
    func fetchFavourites() -> [Meals]{
        let fetchRequest: NSFetchRequest<Meals> = Meals.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "favourite != nil")
        //Sorts alphabetically downwards
        let sectionSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let sortDescriptors = [sectionSortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        let foundMeals = try? PersistenceService.context.fetch(fetchRequest)
        if(foundMeals == nil){
            print("Error fetching meals")
            return []
        }
        else{
            return foundMeals!
        }
    }
    
    func fetchMeals(day: Date) -> [Meals]{
        let fetchRequest: NSFetchRequest<Meals> = Meals.fetchRequest()
        let dayToShow = ModelController().formatDateToDay(date: day)
        fetchRequest.predicate = NSPredicate(format: "day.date == %@", dayToShow)
        //Sorts by short time - currently not correctly
        let sectionSortDescriptor = NSSortDescriptor(key: "time", ascending: true)
        let sortDescriptors = [sectionSortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        let foundMeals = try? PersistenceService.context.fetch(fetchRequest)
        if(foundMeals == nil){
            print("Error fetching meals")
            return []
        }
        else{
            return foundMeals!
        }
    }
    func fetchGlucose(day: Date) -> [Glucose]{
        let fetchRequest: NSFetchRequest<Glucose> = Glucose.fetchRequest()
        let dayToShow = ModelController().formatDateToDay(date: day)
        fetchRequest.predicate = NSPredicate(format: "day.date == %@", dayToShow)
        //Sorts by short time - currently not correctly
        let sectionSortDescriptor = NSSortDescriptor(key: "time", ascending: true)
        let sortDescriptors = [sectionSortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        let foundGlucose = try? PersistenceService.context.fetch(fetchRequest)
        if(foundGlucose == nil){
            print("Error fetching glucose")
            return []
        }
        else{
            return foundGlucose!
        }
    }
    
    func fetchInsulin(day: Date) -> [Insulin]{
        let fetchRequest: NSFetchRequest<Insulin> = Insulin.fetchRequest()
        let dayToShow = ModelController().formatDateToDay(date: day)
        fetchRequest.predicate = NSPredicate(format: "day.date == %@", dayToShow)
        //Sorts by short time - currently not correctly
        let sectionSortDescriptor = NSSortDescriptor(key: "time", ascending: true)
        let sortDescriptors = [sectionSortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        let foundInsulin = try? PersistenceService.context.fetch(fetchRequest)
        if(foundInsulin == nil){
            print("Error fetching insulin")
            return []
        }
        else{
            return foundInsulin!
        }
    }
    
    
    func fetchExercise(day: Date) -> [Exercise]{
        let fetchRequest: NSFetchRequest<Exercise> = Exercise.fetchRequest()
        let dayToShow = ModelController().formatDateToDay(date: day)
        fetchRequest.predicate = NSPredicate(format: "day.date == %@", dayToShow)
        let foundExercise = try? PersistenceService.context.fetch(fetchRequest)
        if(foundExercise == nil){
            print("Error fetching exercise")
            return []
        }
        else{
            return foundExercise!
        }
    }
}
