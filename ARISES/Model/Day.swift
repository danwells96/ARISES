//
//  Day.swift
//  ARISES
//
//  Created by Ryan Armiger on 25/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit
import CoreData

///Day NSManagedObject category/extension file: Contains many computed properties for summarily displaying related object information
class Day: NSManagedObject {
    
    //MARK: - Glucose stats
    ///Returns an optional tuple containing low, avg and high glucose values (as doubles) for that day or nil if no glucose logs exist
    var glucoseStats: (low: Double, average: Double, high: Double)?  {
        guard self.glucose?.anyObject() != nil else {
            return nil
        }
        var tempLow = Double(200)
        var temp = Double(0)
        var tempHigh = Double(0)
        
        for index in (self.glucose?.allObjects)! as! [Glucose]{
            temp = temp + index.value
            if index.value < tempLow{
                tempLow = index.value
            }
            if index.value > tempHigh{
                tempHigh = index.value
            }
        }
        //Average is rounded to 2 decimal places
        let tempAvg = Double(round(100*(temp / Double((self.glucose?.count)!)))/100)
        return (tempLow, tempAvg, tempHigh)
    }

    //MARK: - Meal stats
    ///Returns an optional tuple containing total macros for that day or (0,0,0) if no meal objects found
    var foodStats: (totCarbs: Int32, totProtein: Int32, totFat: Int32)?  {
        guard self.meals?.anyObject() != nil else {
            return (0, 0, 0)
        }
        var tempCarbs = Int32(0)
        var tempFat = Int32(0)
        var tempProtein = Int32(0)
        
        for index in (self.meals?.allObjects)! as! [Meals]{
            tempCarbs = tempCarbs + index.carbs
            tempProtein = tempProtein + index.protein
            tempFat = tempFat + index.fat
            
        }
        
        return (tempCarbs, tempProtein, tempFat)

    }
    //MARK: - Misc stats
    ///Returns the total duration of stress logs for the day as a string in HH:mm format or "0" if no logs exist
    var stressDuration: String{
        guard self.stress?.anyObject() != nil else{
            return "0"
        }
        var total = Double(0)
        for index in (stress?.allObjects)!{
            total = total + (index as! Stress).duration
        }
        let date = Date(timeIntervalSinceReferenceDate: total)
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        return timeFormatter.string(from: date)
    }
    ///Returns the total duration of illness logs for the day as a string in HH:mm format or "0" if no logs exist
    var illnessDuration: String{
        guard self.illness?.anyObject() != nil else{
            return "0"
        }
        var total = Double(0)
        for index in (illness?.allObjects)!{
            total = total + (index as! Illness).duration
        }
        let date = Date(timeIntervalSinceReferenceDate: total)
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        return timeFormatter.string(from: date)
    }
    
    //MARK: - Tags e.g. Hypo/Hyper
    ///Returns an optional array of strings, containing any tags ("hypo"/"hyper") that exist in the glucose logs, an empty array if none exist, and Nil if no glucose logs exist.
    var glucoseTags: [String]? {
        guard self.glucose?.anyObject() != nil else{
            return nil
        }
        var trackHypo = false
        var trackHyper = false
        var tagArray: [String] = []
        for index in (self.glucose?.allObjects)! as! [Glucose]{
            if index.tag == "hypo"{
                trackHypo = true
            }
            if index.tag == "hyper"{
                trackHyper = true
            }
        }
        if trackHypo == true{
            tagArray.append("Hypo")
        }
        if trackHyper == true{
            tagArray.append("Hyper")
        }
        return tagArray
    }

}
