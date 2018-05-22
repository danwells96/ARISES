//
//  CoreDataHandler.swift
//  ARISES
//
//  Created by Ryan Armiger on 21/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

/*import UIKit
import CoreData

class CoreDataHandler: NSObject {
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
      return appDelegate.persistentContainer.viewContext
    }
    
    class func saveObject(name: String, time: String, carbs: Int, protein: Int, fat: Int, favourite: Bool) -> Bool{
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Meals", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(name, forKey: "Name")
        manageObject.setValue(time, forKey: "Time")
        manageObject.setValue(carbs, forKey: "Carbs")
        manageObject.setValue(protein, forKey: "Protein")
        manageObject.setValue(fat, forKey: "Fat")
        manageObject.setValue(favourite, forKey: "Favourite")
        
        do{
            try context.save()
            return true
        }catch{
            return false
        }
    
    }
    
    class func fetchObject() -> [Meals]?{
        let context = getContext()
        var loggedMeals:[Meals]? = nil
        do{
            loggedMeals = try context.fetch(Meals.fetchRequest())
            return loggedMeals
        } catch{
            return loggedMeals
        }
    }
    
}*/
