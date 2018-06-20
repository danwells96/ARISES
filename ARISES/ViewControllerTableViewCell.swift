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
    func didPressButton(_ tag: Int)
    @objc optional func didPressViewDayButton(_ tag: Int)
}

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
    //cell delegate property
    weak var cellDelegate: tableCellDelegate?

    
    //MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Cell button delegates
    @IBAction func buttonPressed(_ sender: UIButton) {
        cellDelegate?.didPressButton(self.tag)
    }
    @IBAction func buttonPressedExercise(_ sender: UIButton) {
        cellDelegate?.didPressButton(self.tag)
    }
    @IBAction func buttonPressedHealth(_ sender: UIButton) {
        cellDelegate?.didPressButton(self.tag)
    }
    @IBAction func didPressViewDay(_ sender: Any) {
        cellDelegate?.didPressViewDayButton!(self.tag)
    }
    
}
