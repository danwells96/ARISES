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
    @IBOutlet var viewBig: UIView!
    
    //Food Outlets
    @IBOutlet weak var viewExpandedFood: UIView!
    @IBOutlet weak var foodNameField: UITextField!
    @IBOutlet weak var foodTimeField: UITextField!
    @IBOutlet weak var foodCarbsField: UITextField!
    @IBOutlet weak var foodProteinField: UITextField!
    @IBOutlet weak var foodFatField: UITextField!
    @IBOutlet weak var foodLogTable: UITableView!
    @IBOutlet weak var addFoodButton: UIButton!
    
    //Health Outlets
    @IBOutlet weak var viewExpandedHealth: UIView!
    @IBOutlet weak var stressField: UITextField!
    @IBOutlet weak var sickSwitch: UISwitch!
    @IBOutlet weak var sickField: UITextField!
    @IBOutlet weak var sickText: UILabel!
    @IBOutlet weak var trendsText: UILabel!
    @IBOutlet weak var stressText: UILabel!
    @IBOutlet weak var hypoTrendButton: UIButton!
    @IBOutlet weak var hyperTrendButton: UIButton!
    @IBOutlet weak var illnessTrendButton: UIButton!
    @IBOutlet weak var exerciseTrendButton: UIButton!
    @IBOutlet weak var foodTrendButton: UIButton!
    @IBOutlet weak var otherTrendButton: UIButton!
    
    //Exercise Outlets
    @IBOutlet weak var viewExpandedExercise: UIView!
    @IBOutlet weak var exerciseLogTable: UITableView!
    @IBOutlet weak var addExerciseButton: UIButton!
    @IBOutlet weak var exerciseNameField: UITextField!
    @IBOutlet weak var exerciseIntensityField: UITextField!
    @IBOutlet weak var exerciseDurationField: UITextField!
    @IBOutlet weak var exerciseTimeField: UITextField!
    
    
    //Advice Outlets
    @IBOutlet weak var viewExpandedAdvice: UIView!
    
    //Hider functions
    func hideFoodOutlets(food: Bool){
        foodNameField.isHidden = food
        foodTimeField.isHidden = food
        foodCarbsField.isHidden = food
        foodProteinField.isHidden = food
        foodFatField.isHidden = food
        foodLogTable.isHidden = food
        addFoodButton.isHidden = food
    }
    func hideHealthOutlets(health: Bool){
        stressField.isHidden = health
        sickSwitch.isHidden = health
        sickField.isHidden = health
        sickText.isHidden = health
        trendsText.isHidden = health
        stressText.isHidden = health
        hypoTrendButton.isHidden = health
        hyperTrendButton.isHidden = health
        illnessTrendButton.isHidden = health
        exerciseTrendButton.isHidden = health
        foodTrendButton.isHidden = health
        otherTrendButton.isHidden = health
    }
    func hideExerciseOutlets(exercise: Bool){
        exerciseLogTable.isHidden = exercise
        addExerciseButton.isHidden = exercise
        exerciseNameField.isHidden = exercise
        exerciseIntensityField.isHidden = exercise
        exerciseDurationField.isHidden = exercise
        exerciseTimeField.isHidden = exercise
    }
    func hideAdviceOutlets(advice: Bool){
        
    }
    
    //defining picker related variables
    let stressLevel = ["not", "a little", "quite", "very"]
    var stressPicker = UIPickerView()
    var foodTimePicker = UIDatePicker()
    let exerciseIntensity = ["Low", "Medium", "High"]
    var exerciseIntensityPicker = UIPickerView()
    var exerciseTimePicker = UIDatePicker()
    var exerciseDurationPicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stressPicker.delegate = self
        stressPicker.dataSource = self
        stressField.inputView = stressPicker
        
        exerciseIntensityPicker.delegate = self
        exerciseIntensityPicker.dataSource = self
        exerciseIntensityField.inputView = exerciseIntensityPicker
        
        createFoodTimePicker()
        createExerciseDurationPicker()
        createExerciseTimePicker()
    }
    
    //Sort through bubbles
    @IBAction func healthButton(_ sender: UIButton) {
        viewBig.bringSubview(toFront: viewExpandedHealth)
        hideFoodOutlets(food: true)
        hideHealthOutlets(health: false)
        hideExerciseOutlets(exercise: true)
    }
    
    @IBAction func foodButton(_ sender: UIButton) {
        viewBig.bringSubview(toFront: viewExpandedFood)
        hideFoodOutlets(food: false)
        hideHealthOutlets(health: true)
        hideExerciseOutlets(exercise: true)
        
    }
    
    @IBAction func exerciseButton(_ sender: UIButton) {
        viewBig.bringSubview(toFront: viewExpandedExercise)
        hideFoodOutlets(food: true)
        hideHealthOutlets(health: true)
        hideExerciseOutlets(exercise: false)
    }
    
    @IBAction func adviceButton(_ sender: UIButton) {
        viewBig.bringSubview(toFront: viewExpandedAdvice)
        hideFoodOutlets(food: true)
        hideHealthOutlets(health: true)
        hideExerciseOutlets(exercise: true)
    }
    
    //Exercise duration picker
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
    
    //Exercise Time picker
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
    
    //Food Time picker
    func createFoodTimePicker(){
        
        let doneButtonBar = UIToolbar()
        doneButtonBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneWithPicker))
        doneButtonBar.setItems([doneButton], animated: false)
        
        foodTimeField.inputAccessoryView = doneButtonBar
        foodTimeField.inputView = foodTimePicker
        
        foodTimePicker.datePickerMode = .time
    }
    
    @objc func doneWithPicker(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        foodTimeField.text = dateFormatter.string(from: foodTimePicker.date)
        self.view.endEditing(true)
    }
    
    //Word Pickers: exercise intensity and stress
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component:Int) -> Int{
        if(pickerView == stressPicker){
            return stressLevel.count
        }
        else{
            return exerciseIntensity.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        if(pickerView == stressPicker){
            return stressLevel[row]
        }
        else{
            return exerciseIntensity[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if(pickerView == stressPicker){
            stressField.text = stressLevel[row]
            stressField.resignFirstResponder()
        }
        else{
            exerciseIntensityField.text = exerciseIntensity[row]
            exerciseIntensityField.resignFirstResponder()
        }
    }
    
}
