//
//  IndicatorControllerFood.swift
//  ARISES
//
//  Created by Ryan Armiger on 30/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import Foundation
import UIKit

class IndicatorControllerFood: UIViewController {

    @IBOutlet weak var indicatorTotalCarb: UILabel!
    @IBOutlet weak var indicatorTotalProtein: UILabel!
    @IBOutlet weak var indicatorTotalFat: UILabel!
    

    var currentDay: Day = ModelController().findOrMakeDay(day: Date())
    let nc = NotificationCenter.default
    var main: ViewControllerMain? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        main = ViewControllerMain()
        nc.addObserver(self, selector: #selector(foodStatsUpdated), name: Notification.Name("FoodAdded"), object: nil)
        nc.addObserver(self, selector: #selector(updateDay(notification:)), name: Notification.Name("dayChanged"), object: nil)
        

        // Do any additional setup after loading the view.
        indicatorTotalCarb.text = "\((currentDay.foodStats?.totCarbs)!)g"
        indicatorTotalFat.text = "\((currentDay.foodStats?.totFat)!)g"
        indicatorTotalProtein.text = "\((currentDay.foodStats?.totProtein)!)g"
    }

    @objc private func foodStatsUpdated(){

        indicatorTotalCarb.text = "\((currentDay.foodStats?.totCarbs)!)g"
        indicatorTotalFat.text = "\((currentDay.foodStats?.totFat)!)g"
        indicatorTotalProtein.text = "\((currentDay.foodStats?.totProtein)!)g"
    }
    /*
    @objc private func dayUpdated(){
        currentDay = ModelController().findOrMakeDay(day: today)
        print("current day in indicator \(currentDay.date)")
        foodStatsUpdated()
    }*/
    
     @objc func updateDay(notification: Notification) {
        currentDay = ModelController().findOrMakeDay(day: notification.object as! Date)
        foodStatsUpdated()
     }
    
    
    
    

}
