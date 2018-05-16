//
//  ViewControllerTableViewCell.swift
//  ARISES
//
//  Created by Ryan Armiger on 16/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var loggedFoodStar: UIImageView!
    @IBOutlet weak var loggedFoodName: UILabel!
    @IBOutlet weak var loggedFoodTime: UILabel!
    @IBOutlet weak var loggedExerciseDuration: UILabel!
    @IBOutlet weak var loggedExerciseName: UILabel!
    @IBOutlet weak var loggedExerciseTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
