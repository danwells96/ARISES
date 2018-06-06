//
//  ViewControllerExercise.swift
//  ARISES
//
//  Created by Ryan Armiger on 16/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerExercise: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate, tableCellDelegate{
    
    //TODO: - Update to add favourites code from food section
    
    //MARK: - Properties
    @IBOutlet weak var exerciseNameField: UITextField!
    @IBOutlet weak var exerciseTimeField: UITextField!
    @IBOutlet weak var exerciseIntensityField: UITextField!
    @IBOutlet weak var exerciseDurationField: UITextField!
    @IBOutlet weak var exerciseLogTable: UITableView!
    //picker related variables
    private let exerciseIntensity = ["Low", "Medium", "High"]
    private var exerciseIntensityPicker = UIPickerView()
    private var exerciseTimePicker = UIDatePicker()
    private var exerciseDurationPicker = UIDatePicker()
    //table related variables
    @IBOutlet weak var favouritesButton: UIButton!
    
    private var loggedExercise = [Exercise]()
    
    private var showFavouritesExercise = false{
        didSet{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                if self.showFavouritesExercise == false{
                    self.favouritesButton.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
                }
                else{
                    self.favouritesButton.tintColor = #colorLiteral(red: 0.9764705882, green: 0.6235294118, blue: 0.2196078431, alpha: 1)
                }
                self.updateTable()
            }
        }

    }

    //MARK: - Override
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
        
        
        
        favouritesButton.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        updateTable()

    }
    
    //MARK: - Picker functions
    //Exercise duration picker
    private func createExerciseDurationPicker(){
        
        let doneButtonBar = UIToolbar()
        doneButtonBar.sizeToFit()
        
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: #selector(doneWithTimePicker))
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(doneWithDurationPicker))
        doneButtonBar.setItems([flexible, doneButton], animated: false)
        
        exerciseDurationField.inputAccessoryView = doneButtonBar
        exerciseDurationField.inputView = exerciseDurationPicker
        
        exerciseDurationPicker.datePickerMode = .countDownTimer
    }
    
    @objc private func doneWithDurationPicker(){
        let hours = Int(exerciseDurationPicker.countDownDuration) / 3600
        let minutes = Int(exerciseDurationPicker.countDownDuration) / 60 % 60
        exerciseDurationField.text = "\(hours) h \(minutes) m"
        self.view.endEditing(true)
    }
    
    //Exercise Time picker
    private func createExerciseTimePicker(){
        
        let doneButtonBar = UIToolbar()
        doneButtonBar.sizeToFit()
        
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: #selector(doneWithTimePicker))
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneWithTimePicker))
        
        doneButtonBar.setItems([flexible, doneButton], animated: false)
        
        exerciseTimeField.inputAccessoryView = doneButtonBar
        exerciseTimeField.inputView = exerciseTimePicker
        
        exerciseTimePicker.datePickerMode = .time
    }
    
    @objc private func doneWithTimePicker(){
        exerciseTimeField.text = ModelController().formatDateToHHmm(date: exerciseTimePicker.date)
        self.view.endEditing(true)
    }
    
    //Word Pickers: exercise intensity
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    @IBAction func toggleFavourites(_ sender: Any) {
        if self.showFavouritesExercise == false{
            showFavouritesExercise = true
        }
        else{
            showFavouritesExercise = false
        }
    }
    
    func didPressButton(_ tag: Int) {
        if showFavouritesExercise != true{
            let toFav = loggedExercise[tag]
            ModelController().toggleFavouriteExercise(item: toFav)
            updateTable()
        }
    }
    
    ////sorry I know this is the worst code ever
    func didPressCameraButton(_tag: Int) {
        let _ = 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component:Int) -> Int{
        return exerciseIntensity.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return exerciseIntensity[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        exerciseIntensityField.text = exerciseIntensity[row]
        exerciseIntensityField.resignFirstResponder()
    }
    
    //MARK: - Table functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return loggedExercise.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        cell.cellDelegate = self
        cell.tag = indexPath.row
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = #colorLiteral(red: 0.9455107252, green: 0.9455107252, blue: 0.9455107252, alpha: 1)
        cell.selectedBackgroundView = backgroundView
        
        let currentExercise = loggedExercise[indexPath.row]
        
        cell.loggedExerciseName.text = currentExercise.name
        cell.loggedExerciseTime.text = currentExercise.time
        cell.loggedExerciseDuration.text = currentExercise.duration
        
        if ModelController().itemInFavouritesExercise(item: currentExercise){
            cell.favouriteExerciseButton.tintColor = #colorLiteral(red: 0.9764705882, green: 0.6235294118, blue: 0.2196078431, alpha: 1)
        }
        else{
            cell.favouriteExerciseButton.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        }
        
        if showFavouritesExercise == true{
            cell.loggedExerciseTime.isHidden = true
        }
        else{
            cell.loggedExerciseTime.isHidden = false
        }
        
        return(cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if showFavouritesExercise == true{
            ModelController().addExercise(
                name: loggedExercise[indexPath.row].name!,
                time: ModelController().formatDateToTime(date: Date()),
                date: Date(),
                intensity: loggedExercise[indexPath.row].intensity!,
                duration: loggedExercise[indexPath.row].duration!)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                self.showFavouritesExercise = false
            }
        }
        
    }
    
    private func updateTable(){
        if showFavouritesExercise == true{
            let loggedExercise = ModelController().fetchFavouritesExercise()
            self.loggedExercise = loggedExercise
            self.exerciseLogTable.reloadData()
        }
        else{
            let loggedExercise = ModelController().fetchExercise(day: Date())
            self.loggedExercise = loggedExercise
            self.exerciseLogTable.reloadData()
        }
    }
    
    @objc private func doneWithKeypad(){
        view.endEditing(true)
    }
    
    @IBAction func addExercise(_ sender: Any) {
        if ((exerciseNameField.text != "") && (exerciseTimeField.text != "") && (exerciseDurationField.text != "") && (exerciseIntensityField.text != "")){

            ModelController().addExercise(
                name: exerciseNameField.text!,
                time: exerciseTimeField.text!,
                date: Date(),
                intensity: exerciseIntensityField.text!,
                duration: exerciseDurationField.text!)
            showFavouritesExercise = false

            
            exerciseNameField.text = ""
            exerciseTimeField.text = ""
            exerciseDurationField.text = ""
            exerciseIntensityField.text = ""
        }
        
    }

}
