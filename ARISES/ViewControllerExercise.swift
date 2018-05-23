//
//  ViewControllerExercise.swift
//  ARISES
//
//  Created by Ryan Armiger on 16/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ViewControllerExercise: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate{
    
    //TODO: exercise logs not working
    
    //MARK: Properties
    @IBOutlet weak var exerciseNameField: UITextField!
    @IBOutlet weak var exerciseTimeField: UITextField!
    @IBOutlet weak var exerciseIntensityField: UITextField!
    @IBOutlet weak var exerciseDurationField: UITextField!
    @IBOutlet weak var exerciseLogTable: UITableView!
    //picker related variables
    let exerciseIntensity = ["Low", "Medium", "High"]
    var exerciseIntensityPicker = UIPickerView()
    var exerciseTimePicker = UIDatePicker()
    var exerciseDurationPicker = UIDatePicker()
    //table related variables
    var loggedExercise = [Exercise]()

    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseIntensityPicker.delegate = self
        exerciseIntensityPicker.dataSource = self
        exerciseIntensityField.inputView = exerciseIntensityPicker
        
        createExerciseDurationPicker()
        createExerciseTimePicker()
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneWithKeypad))
        
        toolBar.setItems([flexible, doneButton], animated: false)
        
        exerciseNameField.inputAccessoryView = toolBar
        
        let fetchRequest: NSFetchRequest<Exercise> = Exercise.fetchRequest()
        
        do{
            let loggedExercise = try PersistenceService.context.fetch(fetchRequest)
            self.loggedExercise = loggedExercise
            self.exerciseLogTable.reloadData()
        } catch{}

    }
    
    //MARK: Picker functions
    //Exercise duration picker
    func createExerciseDurationPicker(){
        
        let doneButtonBar = UIToolbar()
        doneButtonBar.sizeToFit()
        
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: #selector(doneWithTimePicker))
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(doneWithDurationPicker))
        doneButtonBar.setItems([flexible, doneButton], animated: false)
        
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
    
    //Exercise Time picker
    func createExerciseTimePicker(){
        
        let doneButtonBar = UIToolbar()
        doneButtonBar.sizeToFit()
        
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: #selector(doneWithTimePicker))
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneWithTimePicker))
        
        doneButtonBar.setItems([flexible, doneButton], animated: false)
        
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
    
    //Word Pickers: exercise intensity
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
    
    //MARK: Table functions
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return loggedExercise.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        let currentExercise = loggedExercise[indexPath.row]
        cell.loggedExerciseName.text = currentExercise.name
        cell.loggedExerciseTime.text = currentExercise.time
        cell.loggedExerciseDuration.text = currentExercise.duration
        
        return(cell)
    }
    
    @objc func doneWithKeypad(){
        view.endEditing(true)
    }
    
    @IBAction func addExercise(_ sender: Any) {
        if ((exerciseNameField.text != "") && (exerciseTimeField.text != "") && (exerciseDurationField.text != "") && (exerciseIntensityField.text != "")){
            let newExercise = Exercise(context: PersistenceService.context)
            newExercise.name = exerciseNameField.text
            newExercise.time = exerciseTimeField.text
            newExercise.duration = exerciseDurationField.text
            newExercise.intensity = exerciseIntensityField.text
            PersistenceService.saveContext()
            self.loggedExercise.append(newExercise)
            self.exerciseLogTable.reloadData()
            
            exerciseNameField.text = ""
            exerciseTimeField.text = ""
            exerciseDurationField.text = ""
            exerciseIntensityField.text = ""
        }
        
    }

}
