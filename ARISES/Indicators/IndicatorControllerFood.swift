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

    //MARK: - Outlets
    @IBOutlet weak var indicatorTotalCarb: UILabel!
    @IBOutlet weak var indicatorTotalProtein: UILabel!
    @IBOutlet weak var indicatorTotalFat: UILabel!
    
    //MARK: - Properties
    ///Tracks date set by graph and updates indicator values
    private var currentDay: Day = ModelController().findOrMakeDay(day: Date())
    private let nc = NotificationCenter.default
    
    //MARK: - Override viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Observer to update indicators when new meal added
        nc.addObserver(self, selector: #selector(foodStatsUpdated), name: Notification.Name("FoodAdded"), object: nil)
        //Observer to update currentDay variable to match graph's day
        nc.addObserver(self, selector: #selector(updateDay(notification:)), name: Notification.Name("dayChanged"), object: nil)
        
        indicatorTotalCarb.text = "\((currentDay.foodStats?.totCarbs)!)g"
        indicatorTotalFat.text = "\((currentDay.foodStats?.totFat)!)g"
        indicatorTotalProtein.text = "\((currentDay.foodStats?.totProtein)!)g"
    }

    //MARK: - Observer update functions
    ///Updates values on indicators to currentDay's totals
    @objc private func foodStatsUpdated(){
        indicatorTotalCarb.text = "\((currentDay.foodStats?.totCarbs)!)g"
        indicatorTotalFat.text = "\((currentDay.foodStats?.totFat)!)g"
        indicatorTotalProtein.text = "\((currentDay.foodStats?.totProtein)!)g"
    }
    ///Updates the currentDay variable with a date provided via notification from ViewControllerGraph
     @objc func updateDay(notification: Notification) {
        currentDay = ModelController().findOrMakeDay(day: notification.object as! Date)
        foodStatsUpdated()
     }
    
    
    
    

}
