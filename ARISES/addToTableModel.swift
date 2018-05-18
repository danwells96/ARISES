//
//  addToTableModel.swift
//  ARISES
//
//  Created by Ryan Armiger on 18/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {

    var name: String
    var time: NSDate
    var photo: UIImage?
    var carbs: Int
    var protein: Int
    var fat: Int
    
    init?(name: String, time: NSDate, photo: UIImage?, carbs: Int, protein: Int, fat: Int) {
        guard !name.isEmpty else{
            return nil
        }
        self.name = name
        self.time = time
        self.photo = photo
        self.carbs = carbs
        self.protein = protein
        self.fat = fat
    }
    
    struct PropertyKey{
        
        static let name = "name"
        static let time = "time"
        static let photo = "photo"
        static let carbs = "carbs"
        static let protein = "protein"
        static let fat = "fat"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(time, forKey: PropertyKey.time)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(carbs, forKey: PropertyKey.carbs)
        aCoder.encode(protein, forKey: PropertyKey.protein)
        aCoder.encode(fat, forKey: PropertyKey.fat)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {

        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        let time = aDecoder.decodeObject(forKey: PropertyKey.time)
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let carbs = aDecoder.decodeObject(forKey: PropertyKey.carbs)
        let protein = aDecoder.decodeObject(forKey: PropertyKey.protein)
        let fat = aDecoder.decodeObject(forKey: PropertyKey.fat)
    
        self.init(name: name, time: time as! NSDate, photo: photo, carbs: carbs as! Int, protein: protein as! Int, fat: fat as! Int)
        
    }
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
}
