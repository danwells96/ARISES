//
//  ViewController.swift
//  ARISES
//
//  Created by Ryan Armiger on 05/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var viewExpandedFood: UIView!
    @IBOutlet weak var viewExpandedHealth: UIView!
    @IBOutlet weak var viewExpandedExercise: UIView!
    @IBOutlet weak var viewExpandedAdvice: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Actions

    @IBAction func smallFoodButton(_ sender: UIButton) {
        viewExpandedFood.isHidden = false
        viewExpandedHealth.isHidden = true
        viewExpandedExercise.isHidden = true
        viewExpandedAdvice.isHidden = true
    }
    
    @IBAction func smallHealthButton(_ sender: UIButton) {
        viewExpandedFood.isHidden = true
        viewExpandedHealth.isHidden = false
        viewExpandedExercise.isHidden = true
        viewExpandedAdvice.isHidden = true
    }
    
    @IBAction func smallExerciseButton(_ sender: UIButton) {
        viewExpandedFood.isHidden = true
        viewExpandedHealth.isHidden = true
        viewExpandedExercise.isHidden = false
        viewExpandedAdvice.isHidden = true
    }
    
    @IBAction func smallAdviceButton(_ sender: UIButton) {
        viewExpandedFood.isHidden = true
        viewExpandedHealth.isHidden = true
        viewExpandedExercise.isHidden = true
        viewExpandedAdvice.isHidden = false
    }
    
    @IBAction func collapseFood(_ sender: UIButton){
        viewExpandedFood.isHidden = true
    }
    @IBAction func collapseAdvice(_ sender: UIButton) {
        viewExpandedAdvice.isHidden = true
    }
    @IBAction func collapseExercise(_ sender: UIButton) {
        viewExpandedExercise.isHidden = true
    }
    @IBAction func collapseHealth(_ sender: UIButton) {
        viewExpandedHealth.isHidden = true
    }
    
    
    
}
