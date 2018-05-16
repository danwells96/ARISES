//
//  ViewControllerMain.swift
//  ARISES
//
//  Created by Ryan Armiger on 16/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerMain: UIViewController {
    
    //MARK: Properties
    // Views with status indicators
    @IBOutlet weak var viewHealth: UIView!
    @IBOutlet weak var viewFood: UIView!
    @IBOutlet weak var viewAdvice: UIView!
    @IBOutlet weak var viewExercise: UIView!
    // Containers for embedding view contents
    @IBOutlet weak var containerHealth: UIView!
    @IBOutlet weak var containerFood: UIView!
    @IBOutlet weak var containerAdvice: UIView!
    @IBOutlet weak var containerExercise: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Sort through bubbles
    @IBAction func healthButton(_ sender: UIButton) {
        view.bringSubview(toFront: viewHealth)
        containerFood.isHidden = true
        containerAdvice.isHidden = true
        containerHealth.isHidden = false
        containerExercise.isHidden = true
    }
    
    @IBAction func foodButton(_ sender: UIButton) {
        view.bringSubview(toFront: viewFood)
        containerFood.isHidden = false
        containerAdvice.isHidden = true
        containerHealth.isHidden = true
        containerExercise.isHidden = true
    }
    
    @IBAction func exerciseButton(_ sender: UIButton) {
        view.bringSubview(toFront: viewExercise)
        containerFood.isHidden = true
        containerAdvice.isHidden = true
        containerHealth.isHidden = true
        containerExercise.isHidden = false
    }
    
    @IBAction func adviceButton(_ sender: UIButton) {
        view.bringSubview(toFront: viewAdvice)
        containerFood.isHidden = true
        containerAdvice.isHidden = false
        containerHealth.isHidden = true
        containerExercise.isHidden = true
    }
 
    
}
