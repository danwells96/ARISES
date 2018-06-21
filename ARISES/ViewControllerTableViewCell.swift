//
//  ViewControllerTableViewCell.swift
//  ARISES
//
//  Created by Ryan Armiger on 16/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit

///Table cell delegate for button actions
@objc protocol tableCellDelegate : class {
    ///Calls didPressButton in each ViewController with a table
    func didPressButton(_ tag: Int)
    ///Optional function for use in ViewControllerHealth, to set graph day to view from table.
    @objc optional func didPressViewDayButton(_ tag: Int)
}

/**
 View Controller For Table Cells: Links outlets to be set in other ViewControllers and Button Actions to call delegate functions
 */
class ViewControllerTableViewCell: UITableViewCell {

    //MARK: - Outlets
    //Food outlets
    @IBOutlet weak var loggedFoodName: UILabel!
    @IBOutlet weak var loggedFoodTime: UILabel!
    @IBOutlet weak var loggedFoodCarbs: UILabel!
    @IBOutlet weak var loggedFoodProtein: UILabel!
    @IBOutlet weak var loggedFoodFat: UILabel!
    
    @IBOutlet weak var editFoodButton: UIButton!
    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var favouriteFoodButton: UIButton!
    
    //Exercise outlets
    @IBOutlet weak var favouriteExerciseButton: UIButton!
    @IBOutlet weak var loggedExerciseDuration: UILabel!
    @IBOutlet weak var loggedExerciseName: UILabel!
    @IBOutlet weak var loggedExerciseTime: UILabel!
    
    //Health outlets
    @IBOutlet weak var dateInLog: UILabel!
    @IBOutlet weak var favouriteHealthButton: UIButton!
    @IBOutlet weak var loggedHealthHypoIcon: UIButton!
    @IBOutlet weak var loggedHealthHyperIcon: UIButton!
    @IBOutlet weak var loggedHealthExerciseIcon: UIButton!
    @IBOutlet weak var loggedHealthStressedIcon: UIButton!
    @IBOutlet weak var loggedHealthIllnessIcon: UIButton!
    @IBOutlet weak var loggedHealthLowLabel: UILabel!
    @IBOutlet weak var loggedHealthAvgLabel: UILabel!
    @IBOutlet weak var loggedHealthHighLabel: UILabel!
    
    //MARK: - Properties
    ///Cell delegate property. Optional and weak to prevent retain cycles
    weak var cellDelegate: tableCellDelegate?


    //MARK: - Cell button delegates
    ///Food log favourites button action
    @IBAction func buttonPressed(_ sender: UIButton) {
        cellDelegate?.didPressButton(self.tag)
    }
    ///Exercsie log favourites button action
    @IBAction func buttonPressedExercise(_ sender: UIButton) {
        cellDelegate?.didPressButton(self.tag)
    }
    ///Health log favourites button action
    @IBAction func buttonPressedHealth(_ sender: UIButton) {
        cellDelegate?.didPressButton(self.tag)
    }
    ///Health log `view` button action
    @IBAction func didPressViewDay(_ sender: Any) {
        cellDelegate?.didPressViewDayButton!(self.tag)
    }
    
}
