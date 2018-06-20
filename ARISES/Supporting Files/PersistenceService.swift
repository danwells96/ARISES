//
//  PersistenceService.swift
//  ARISES
//
//  Created by Ryan Armiger on 22/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import Foundation
import CoreData

///Initialises a persistent store and provides functions to allow ModelController to add objects to it's context and save that context.
class PersistenceService{
    ///Init for PersistenceService class
    private init(){}
    
    /// Initialises a space for groups of related model objects that represent a view of a persistent store. Changes are held in memory in the context until saved to a persistent store
    static var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    ///The persistent container or store for the application
    static var persistentContainer: NSPersistentContainer = {
        /*
         This implementation creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "ARISES")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.You should not use this function in a shipping application, although t may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallowswriting.
                 * The persistent store is not accessible, due to permissions or ata protection when the device is locked
                 * The device is out of space
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    ///Saves the context to a persistent store
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

