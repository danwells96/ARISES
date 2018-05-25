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
  /*
    private var currentDay: Day
    private var today: String{
        didSet{
            //create new log if new day set
            let currentDay = Day(context: PersistenceService.context)
            currentDay.date = today
            PersistenceService.saveContext()
        }
    }
    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        today = dateFormatter.string(from: Date())
        if
    }
 */


    public func formatDateToDay(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: Date())
    }
    
    private func createNewDay(dateValue: Date) -> Day{
        //create new log if new day set
        let currentDay = Day(context: PersistenceService.context)
        currentDay.date = formatDateToDay(date: dateValue)
        PersistenceService.saveContext()
        return currentDay
    }
    /*
    public func updateDay(newDate: Date){
        //If new day
        if today != (formatDateToDay(date: newDate)){
            //TODO: add a check for days in future
            today = formatDateToDay(date: newDate)
        }
    }
   */
    private func searchForDay(search: Date) -> Day?{
        let day = formatDateToDay(date: search)
        //predicate date
        let dateFetch: NSFetchRequest<Day> = Day.fetchRequest()
       dateFetch.predicate = NSPredicate(format: "date == %@", day)
        let checkForDay = try? PersistenceService.context.fetch(dateFetch)
        if checkForDay != nil{
            if checkForDay?.count != 0{
                return checkForDay!.first
            }
            
        }
        return nil
    }
    
    public func addMeal(name: String, time: String, date: Date, carbs: Int32, fat: Int32, protein: Int32){
        
        var currentDay: Day? = nil
        if searchForDay(search: date) != nil{
            currentDay = searchForDay(search: date)!
        }
        else{
            currentDay = createNewDay(dateValue: date)
        }
        //try add to existing?
        let newMeal = Meals(context: PersistenceService.context)
        newMeal.name = name
        newMeal.time = time
        newMeal.carbs = carbs
        newMeal.protein = protein
        newMeal.fat = fat
        currentDay!.addToMeals(newMeal)
        
      
        PersistenceService.saveContext()
    }
}
