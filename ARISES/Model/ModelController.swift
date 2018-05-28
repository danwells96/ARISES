//
//  ModelController.swift
//  ARISES
//
//  Created by Ryan Armiger on 25/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import Foundation
import CoreData

/*
 //Some way to abstract all these functions would be super helpful
enum entity{
    case meal
    case exercise
    case day
    case favourite
}
*/

class ModelController {

    
    func formatDateToDay(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: Date())
    }
    //MARK: Private functions
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
    
    private func createNewDay(dateValue: Date) -> Day{
        //create new log if new day set
        let currentDay = Day(context: PersistenceService.context)
        currentDay.date = formatDateToDay(date: dateValue)
        PersistenceService.saveContext()
        return currentDay
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
    //MARK: Functions for use by other controllers e.g. Adding logs/ fetching
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
    func itemInFavourites(item: Meals) -> Bool{
        
        let favList = checkForExistingFavourites()
        for index in favList.objectIDs(forRelationshipNamed: "meals"){
            if index == item.objectID{
                return true
            }
        }
        return false
    }
    
    func fetchFavourites() -> [Meals]{
        let fetchRequest: NSFetchRequest<Meals> = Meals.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "favourite != nil")
        let foundMeals = try? PersistenceService.context.fetch(fetchRequest)
        if(foundMeals == nil){
            print("Error fetching meals")
            return []
        }
        else{
            //print("\(foundMeals!)")
            return foundMeals!
            
        }
    }
    
    func fetchMeals(day: Date) -> [Meals]{
        let fetchRequest: NSFetchRequest<Meals> = Meals.fetchRequest()
        let dayToShow = ModelController().formatDateToDay(date: day)
        fetchRequest.predicate = NSPredicate(format: "day.date == %@", dayToShow)
        let foundMeals = try? PersistenceService.context.fetch(fetchRequest)
        if(foundMeals == nil){
            print("Error fetching meals")
            return []
        }
        else{
            return foundMeals!
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
