//
//  ViewControllerExercise.swift
//  ARISES
//
//  Created by Ryan Armiger on 16/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit

class ViewControllerExercise: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate, tableCellDelegate{
    
    //MARK: - Outlets
    @IBOutlet weak private var exerciseNameField: UITextField!
    @IBOutlet weak private var exerciseTimeField: UITextField!
    @IBOutlet weak private var exerciseIntensityField: UITextField!
    @IBOutlet weak private var exerciseDurationField: UITextField!
    @IBOutlet weak private var exerciseLogTable: UITableView!
    @IBOutlet weak private var logTopConstraint: NSLayoutConstraint!
    @IBOutlet weak private var barBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak private var exerciseAddButton: UIButton!
    @IBOutlet weak private var favouritesButton: UIButton!
    
    //MARK: - Properties
    //picker related variables
    private let exerciseIntensity = ["Low", "Medium", "High"]
    private var exerciseIntensityPicker = UIPickerView()
    private var exerciseTimePicker = UIDatePicker()
    private var exerciseDurationPicker = UIDatePicker()
    
    ///Tracks date set by graph and hides data entry fields when not on current day
    private var currentDay = Date(){
        didSet{
            exerciseNameField.text = ""
            exerciseTimeField.text = ""
            exerciseDurationField.text = ""
            exerciseIntensityField.text = ""
            
            if currentDay != Calendar.current.startOfDay(for: Date()) {
                exerciseTimeField.isHidden = true
                exerciseNameField.isHidden = true
                exerciseIntensityField.isHidden = true
                exerciseDurationField.isHidden = true
                favouritesButton.isHidden = true
                exerciseAddButton.isHidden = true
                //add constraint adjustment to fill full size
                logTopConstraint.constant = 0
                barBottomConstraint.constant = 0
            }
            else{
                exerciseTimeField.isHidden = false
                exerciseNameField.isHidden = false
                exerciseIntensityField.isHidden = false
                exerciseDurationField.isHidden = false
                favouritesButton.isHidden = false
                exerciseAddButton.isHidden = false
                logTopConstraint.constant = 8
                barBottomConstraint.constant = 8
            }
            self.showFavouritesExercise = false
            view.endEditing(true)
        }
    }
    ///Stores an array of Exercise objects fetched from the model to display in the table
    private var loggedExercise = [Exercise]()
    ///Tracks whether to show favourites or daily log
    private var showFavouritesExercise = false{
        didSet{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                if self.showFavouritesExercise == false{
                    self.favouritesButton.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
                }
                else{
                    self.favouritesButton.tintColor = #colorLiteral(red: 0.3450980392, green: 0.6784313725, blue: 0.8156862745, alpha: 1)
                }
                self.updateTable()
            }
        }

    }

    //MARK: - Override viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Picker overrides
        exerciseIntensityPicker.delegate = self
        exerciseIntensityPicker.dataSource = self
        exerciseIntensityField.inputView = exerciseIntensityPicker
        
        createExerciseDurationPicker()
        createExerciseTimePicker()
        
        //Data entry 'done' toolbars
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneWithKeypad))
        
        toolBar.setItems([flexible, doneButton], animated: false)
        
        exerciseNameField.inputAccessoryView = toolBar
        
        
        let nc = NotificationCenter.default
        //Observers to update currentDay variable to match graph's day
        nc.addObserver(self, selector: #selector(updateDay(notification:)), name: Notification.Name("dayChanged"), object: nil)
        
        //Observers to determine keyboard state and move view so that fields aren't obscured
        nc.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        nc.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        favouritesButton.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        updateTable()

    }
    
    //MARK: - Update Day
    ///Updates the currentDay variable with a date provided via notification from ViewControllerGraph and re-fetches the table
    @objc private func updateDay(notification: Notification) {
        currentDay = notification.object as! Date
        updateTable()
    }
    
   //MARK: - Functions for moving view to prevent keyboard obscuring fields
    @objc private func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -65 // Move view 150 points upward
    }
    @objc private func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
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
    
    @objc private func doneWithKeypad(){
        view.endEditing(true)
    }
    
    //MARK: - Favourite buttons
    //Toggle between favourite and daily log views
    @IBAction private func toggleFavourites(_ sender: Any) {
        if self.showFavouritesExercise == false{
            showFavouritesExercise = true
        }
        else{
            showFavouritesExercise = false
        }
    }
    
    //TODO: Add a way to remove favourites
    ///Delegate function to toggle whether a meal is favourited
    func didPressButton(_ tag: Int) {
        if showFavouritesExercise != true{
            let toFav = loggedExercise[tag]
            ModelController().toggleFavouriteExercise(item: toFav)
            updateTable()
        }
    }
    
    //FIXME: Currently broken delegate function for a camera button
    func didPressCameraButton(_tag: Int) {
        let _ = 1
    }

    //MARK: - Table functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return loggedExercise.count
    }
    
    ///Provides setup for table cells, setting each label
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
            cell.favouriteExerciseButton.tintColor = #colorLiteral(red: 0.3450980392, green: 0.6784313725, blue: 0.8156862745, alpha: 1)
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
    
    //Allows selecting a favourite to add to daily log
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if showFavouritesExercise == true{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"

            exerciseNameField.text = loggedExercise[indexPath.row].name
            exerciseTimeField.text = dateFormatter.string(from: Date())
            exerciseDurationField.text = loggedExercise[indexPath.row].duration
            exerciseIntensityField.text = loggedExercise[indexPath.row].intensity
        }
    }

    ///Updates the table by re-fetching either a list of exercise for that day, or the user's favourites
    private func updateTable(){
        if showFavouritesExercise == true{
            let loggedExercise = ModelController().fetchFavouritesExercise()
            self.loggedExercise = loggedExercise
            self.exerciseLogTable.reloadData()
        }
        else{
            let loggedExercise = ModelController().fetchExercise(day: currentDay)
            self.loggedExercise = loggedExercise
            self.exerciseLogTable.reloadData()
        }
    }

    //MARK: - Add exercise button
    @IBAction private func addExercise(_ sender: Any) {
        if ((exerciseNameField.text != "") && (exerciseTimeField.text != "") && (exerciseDurationField.text != "") && (exerciseIntensityField.text != "")){

            ModelController().addExercise(
                name: exerciseNameField.text!,
                time: exerciseTimeField.text!,
                date: currentDay,
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