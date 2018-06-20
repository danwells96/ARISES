//
//  Stress.swift
//  ARISES
//
//  Created by Ryan Armiger on 04/06/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit
import CoreData

class Stress: NSManagedObject {
    ///Returns total duration of the stress log
    var duration: Double {
        let interval = DateInterval.init(start: self.start!, end: self.end!)
        return interval.duration
    }
}