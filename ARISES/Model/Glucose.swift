//
//  Glucose.swift
//  ARISES
//
//  Created by Ryan Armiger on 29/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//


import UIKit
import CoreData

///Glucose NSManagedObject category/extension file: Contains a computed property `tag` to mark if a log is in the hypo/hyper range
/**
 - Note: The following auto-generated properties are managed within ARISES.xcdatamodeld:
    fetchRequest(),
    time,
    value,
    day
 */
class Glucose: NSManagedObject {
    //MARK: - Computer Properties
    ///Returns an optional string. "hypo" if below 4.0, "hyper" if above 10.0 *Note the case of the strings*
    var tag: String? {
        get {
            if(value < 4.0){
                return "hypo"
            }
            if(value > 10.0){
                return "hyper"
            }
            return nil
        }
    }
    
}
