//
//  ViewController.swift
//  ARISES
//
//  Created by Ryan Armiger on 05/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //MARK: Properties
    @IBOutlet weak var viewExpandedFood: UIView!
    @IBOutlet weak var viewExpandedHealth: UIView!
    @IBOutlet weak var viewExpandedExercise: UIView!
    @IBOutlet weak var viewExpandedAdvice: UIView!
    @IBOutlet var viewBig: UIView!
    @IBOutlet weak var foodList: UILabel!
    @IBOutlet weak var sickControls: UILabel!
    @IBOutlet weak var trendsOOOOOHHH: UILabel!
    @IBOutlet weak var exerciseList: UILabel!
    @IBOutlet weak var adviceNotification: UILabel!
    @IBOutlet weak var stressField: UITextField!
    @IBOutlet weak var sickSwitch: UISwitch!
    
    let stressLevel = ["Low", "Medium", "High"]
    var stressPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stressPicker.delegate = self
        stressPicker.dataSource = self
        stressField.inputView = stressPicker
        stressField.textAlignment = .center
        stressField.placeholder = "Select stress level"
    }
    
    @IBAction func healthButton(_ sender: UIButton) {
        viewBig.bringSubview(toFront: viewExpandedHealth)
        foodList.isHidden = true
        trendsOOOOOHHH.isHidden = false
        sickControls.isHidden = false
        exerciseList.isHidden = true
        adviceNotification.isHidden = true
        sickSwitch.isHidden = false
        stressField.isHidden = false

    }
    
    @IBAction func foodButton(_ sender: UIButton) {
        viewBig.bringSubview(toFront: viewExpandedFood)
        foodList.isHidden = false
        trendsOOOOOHHH.isHidden = true
        sickControls.isHidden = true
        exerciseList.isHidden = true
        adviceNotification.isHidden = true
        sickSwitch.isHidden = true
        stressField.isHidden = true

    }
    
    @IBAction func exerciseButton(_ sender: UIButton) {
        viewBig.bringSubview(toFront: viewExpandedExercise)
        foodList.isHidden = true
        trendsOOOOOHHH.isHidden = true
        sickControls.isHidden = true
        exerciseList.isHidden = false
        adviceNotification.isHidden = true
        sickSwitch.isHidden = true
        stressField.isHidden = true

    }
    
    @IBAction func adviceButton(_ sender: UIButton) {
        viewBig.bringSubview(toFront: viewExpandedAdvice)
        foodList.isHidden = true
        trendsOOOOOHHH.isHidden = true
        sickControls.isHidden = true
        exerciseList.isHidden = true
        adviceNotification.isHidden = false
        sickSwitch.isHidden = true
        stressField.isHidden = true
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component:Int) -> Int{
        return stressLevel.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return stressLevel[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        stressField.text = stressLevel[row]
        stressField.resignFirstResponder()
    }
    
    
}
