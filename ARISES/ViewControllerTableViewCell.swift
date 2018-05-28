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
}

class ViewControllerTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var loggedFoodName: UILabel!
    @IBOutlet weak var loggedFoodTime: UILabel!
    @IBOutlet weak var loggedFoodCarbs: UILabel!
    // @IBOutlet weak var loggedFoodCarbs: UILabel!
    
    @IBOutlet weak var favouriteFoodButton: UIButton!
    
    @IBOutlet weak var loggedExerciseDuration: UILabel!
    @IBOutlet weak var loggedExerciseName: UILabel!
    @IBOutlet weak var loggedExerciseTime: UILabel!
    
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

    

    
    /*
    func set(content: Meals){
        self.loggedFoodName.text = content.name
        self.loggedFoodTime.text = content.time
        
        if(expanded == true){
            self.loggedFoodCarbs.text = "\(content.carbs)"
 
        }
        
    }*/

}
