//
//  ViewControllerExercise.swift
//  ARISES
//
//  Created by Ryan Armiger on 11/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerExercise: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    //MARK: Properties
    
    @IBOutlet weak var exerciseTimeField: UITextField!
    @IBOutlet weak var exerciseIntensityField: UITextField!
    @IBOutlet weak var exerciseDurationField: UITextField!
    
    let exerciseIntensity = ["Low", "Medium", "High"]
    var exerciseIntensityPicker = UIPickerView()
    var exerciseTimePicker = UIDatePicker()
    var exerciseDurationPicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createExerciseTimePicker()
        createExerciseDurationPicker()
        exerciseIntensityPicker.delegate = self
        exerciseIntensityPicker.dataSource = self
        exerciseIntensityField.inputView = exerciseIntensityPicker
    }
    
    func createExerciseTimePicker(){
        
        let doneButtonBar = UIToolbar()
        doneButtonBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneWithTimePicker))
        doneButtonBar.setItems([doneButton], animated: false)
        
        exerciseTimeField.inputAccessoryView = doneButtonBar
        exerciseTimeField.inputView = exerciseTimePicker
        
        exerciseTimePicker.datePickerMode = .time
    }
    
    @objc func doneWithTimePicker(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        exerciseTimeField.text = dateFormatter.string(from: exerciseTimePicker.date)
        self.view.endEditing(true)
    }
    
    func createExerciseDurationPicker(){
        
        let doneButtonBar = UIToolbar()
        doneButtonBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneWithDurationPicker))
        doneButtonBar.setItems([doneButton], animated: false)
        
        exerciseDurationField.inputAccessoryView = doneButtonBar
        exerciseDurationField.inputView = exerciseDurationPicker
        
        exerciseDurationPicker.datePickerMode = .countDownTimer
    }
    
    @objc func doneWithDurationPicker(){
        let hours = Int(exerciseDurationPicker.countDownDuration) / 3600
        let minutes = Int(exerciseDurationPicker.countDownDuration) / 60 % 60
        exerciseDurationField.text = "\(hours) h \(minutes) m"
        self.view.endEditing(true)
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component:Int) -> Int{
        return exerciseIntensity.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return exerciseIntensity[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        exerciseIntensityField.text = exerciseIntensity[row]
        exerciseIntensityField.resignFirstResponder()
    }
    //MARK: Actions
}
