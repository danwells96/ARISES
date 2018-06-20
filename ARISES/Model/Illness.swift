//
//  Illness.swift
//  ARISES
//
//  Created by Ryan Armiger on 04/06/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit
import CoreData

///Illness NSManagedObject category/extension file: Contains a computed property `duration` to compute duration of an illness log
/**
 - Note: The following auto-generated properties are managed within ARISES.xcdatamodeld:
     fetchRequest(),
     end,
     start,
     day
 */
class Illness: NSManagedObject {
    ///Returns total duration of the illness log
    var duration: Double {
        let interval = DateInterval.init(start: self.start!, end: self.end!)
        return interval.duration
    }

}
