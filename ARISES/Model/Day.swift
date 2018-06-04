//
//  Day.swift
//  ARISES
//
//  Created by Ryan Armiger on 25/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit
import CoreData

class Day: NSManagedObject {
    //TODO: add guards so doesn't crash if empty (might not)
    //TODO: check corner cases
    
    //MARK: - Glucose stats
    var glucoseStats: (low: Double, average: Double, high: Double)?  {
        guard self.glucose?.anyObject() != nil else {
            return nil
        }
        var tempLow = Double(0)
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
        return (tempLow, (temp / Double((self.glucose?.count)!)), tempHigh)
    }

    //MARK: - Meal stats
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
    
    //MARK: - Tags e.g. Hypo/Hyper
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
