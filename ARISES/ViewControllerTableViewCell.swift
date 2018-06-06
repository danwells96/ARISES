//
//  ViewControllerTableViewCell.swift
//  ARISES
//
//  Created by Ryan Armiger on 16/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit

protocol tableCellDelegate : class {
    func didPressButton(_ tag: Int)
    func didPressCameraButton(_tag: Int)
}

class ViewControllerTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var loggedFoodName: UILabel!
    @IBOutlet weak var loggedFoodTime: UILabel!
    @IBOutlet weak var loggedFoodCarbs: UILabel!
    @IBOutlet weak var loggedFoodProtein: UILabel!
    @IBOutlet weak var loggedFoodFat: UILabel!
    
    @IBOutlet weak var editFoodButton: UIButton!
    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var favouriteFoodButton: UIButton!
    @IBOutlet weak var favouriteExerciseButton: UIButton!
    
    @IBOutlet weak var favouriteHealthButton: UIButton!
    @IBOutlet weak var loggedExerciseDuration: UILabel!
    @IBOutlet weak var loggedExerciseName: UILabel!
    @IBOutlet weak var loggedExerciseTime: UILabel!
    
    @IBOutlet weak var dateInLog: UILabel!

    
    @IBOutlet weak var loggedHealthHypoIcon: UIButton!
    @IBOutlet weak var loggedHealthHyperIcon: UIButton!
    @IBOutlet weak var loggedHealthExerciseIcon: UIButton!
    @IBOutlet weak var loggedHealthStressedIcon: UIButton!
    @IBOutlet weak var loggedHealthIllnessIcon: UIButton!
    
    
    weak var cellDelegate: tableCellDelegate?

    
    // var expanded = false
    
    
    //MARK: Override
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // connect the button from your cell with this method
    @IBAction func buttonPressed(_ sender: UIButton) {
        cellDelegate?.didPressButton(self.tag)
    }
    @IBAction func buttonPressedExercise(_ sender: UIButton) {
        cellDelegate?.didPressButton(self.tag)
    }
    @IBAction func buttonPressedHealth(_ sender: UIButton) {
        cellDelegate?.didPressButton(self.tag)
    }
    
    @IBAction func buttonPressedCamera(_ sender: UIButton) {
        cellDelegate?.didPressCameraButton(_tag: self.tag)
    }

}
