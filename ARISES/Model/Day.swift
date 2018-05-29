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
    var low: Double? {
        var tempLow = Double(50)
        if (self.glucose?.count)! > 0{
            for index in (self.glucose?.allObjects)! as! [Glucose]{
                if index.value < tempLow{
                    tempLow = index.value
                }
            }
            return tempLow
        }
        return nil
    }
    
    var high: Double? {
        var tempHigh = Double(0)
        if (self.glucose?.count)! > 0{
            for index in (self.glucose?.allObjects)! as! [Glucose]{
                if index.value > tempHigh{
                    tempHigh = index.value
                }
            }
            return tempHigh
        }
        return nil
    }
    
    var average: Double? {
        var temp = Double(0)
        if (self.glucose?.count)! > 0{
            for index in (self.glucose?.allObjects)! as! [Glucose]{
                temp = temp + index.value
            }
            return (temp / Double((self.glucose?.count)!))
        }
        return nil
    }
}
