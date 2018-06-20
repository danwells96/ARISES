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
class Glucose: NSManagedObject {
    //MARK: - Computer Properties
    ///Returns an optional string. "hypo" if below 3.9, "hyper" if above 11.1 *Note the case of the strings*
    var tag: String? {
        get {
            if(value < 3.9){
                return "hypo"
            }
            if(value > 11.1){
                return "hyper"
            }
            return nil
        }
    }
    
}
