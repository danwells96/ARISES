//
//  Glucose.swift
//  ARISES
//
//  Created by Ryan Armiger on 29/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//


import UIKit
import CoreData

class Glucose: NSManagedObject {
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
