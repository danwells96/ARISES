//
//  ViewControllerFood.swift
//  ARISES
//
//  Created by Ryan Armiger on 16/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit

/**
 Controls all UI elements within the food domain. This includes data entry, favouriting system and managing the food log.
 */
class ViewControllerFood: UIViewController, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate, tableCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak private var foodTimeField: UITextField!
    //Food Entry Outlets
    @IBOutlet weak private var carbsTextField: UITextField!
    @IBOutlet weak private var proteinTextField: UITextField!
    @IBOutlet weak private var fatTextField: UITextField!
    @IBOutlet weak private var foodNameTextField: UITextField!
    @IBOutlet weak private var favouritesButton: UIButton!
    @IBOutlet weak private var foodAddButton: UIButton!
    //Food daily log table
    @IBOutlet weak private var foodLogTable: UITableView!
    //Constraints to allow adjusting when moving between days and hiding data entry outlets
    @IBOutlet weak private var logTopConstraint: NSLayoutConstraint!
    @IBOutlet weak private var barBottomConstraint: NSLayoutConstraint!

    
    //MARK: - Properties
    ///Instantiation of a date picker for choosing time of meal
    private var foodTimePicker = UIDatePicker()
    ///Tracks date set by graph and hides data entry fields when not on current day using didSet
    private var currentDay = Date(){
        didSet{

            foodNameTextField.text = ""
            foodTimeField.text = ""
            carbsTextField.text = ""
            proteinTextField.text = ""
            fatTextField.text = ""
            
            if currentDay != Calendar.current.startOfDay(for: Date()) {
                foodTimeField.isHidden = true
                foodNameTextField.isHidden = true
                carbsTextField.isHidden = true
                proteinTextField.isHidden = true
                fatTextField.isHidden = true
                favouritesButton.isHidden = true
                foodAddButton.isHidden = true
                logTopConstraint.constant = 0
                barBottomConstraint.constant = 0
            }
            else{
                foodTimeField.isHidden = false
                foodNameTextField.isHidden = false
                carbsTextField.isHidden = false
                proteinTextField.isHidden = false
                fatTextField.isHidden = false
                favouritesButton.isHidden = false
                foodAddButton.isHidden = false
                logTopConstraint.constant = 8
                barBottomConstraint.constant = 8
            }
            self.showFavouritesFood = false
            view.endEditing(true)
        }
    }

    //Table variables
    ///Stores an array of Meals objects fetched from the model to display in the table
    private var loggedMeals = [Meals]()
    ///Stores index of selected cell to allow expanding to show more info when selected
    private var selectedCellIndexPath = [IndexPath?]()
    ///Height for a cell which has been selected and expanded
    private let selectedCellHeight: CGFloat = 89.0
    ///Height for an unselected and contracted cell
    private let unselectedCellHeight: CGFloat = 40.0
    ///Tracks whether to show favourites or daily log
    private var showFavouritesFood = false{
        didSet{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                if self.showFavouritesFood == false{
                    self.favouritesButton.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
                }
                else{
                    self.favouritesButton.tintColor = #colorLiteral(red: 0.9764705882, green: 0.6235294118, blue: 0.2196078431, alpha: 1)
                }
                self.updateTable()
            }
        }
    }

    //MARK: - Override viewDidLoad
    /**viewDidLoad override to set initial state of:
     food log delegate and data source,
     TimePicker instantiation,
     Observer to act on current graph day changing,
     Observers to act based on keyboard state,
     Calling `updateTable`
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        //Table view delegate requirements
        foodLogTable.dataSource = self
        foodLogTable.delegate = self
        
        //Instantiation of time picker
        createFoodTimePicker()
        
        //Data entry 'done' toolbars
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneWithKeypad))
        
        toolBar.setItems([flexible, doneButton], animated: true)
        
        carbsTextField.inputAccessoryView = toolBar
        proteinTextField.inputAccessoryView = toolBar
        fatTextField.inputAccessoryView = toolBar
        foodNameTextField.inputAccessoryView = toolBar
        
        let nc = NotificationCenter.default
        //Observer to update currentDay variable to match graph's day
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
    /// Moves food view 65 points upward
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -65
    }
    /// Moves food view to original position
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    //MARK: - Picker functions
    ///Food Time picker
    private func createFoodTimePicker(){
        
        let doneButtonBar = UIToolbar()
        doneButtonBar.sizeToFit()
        
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: #selector(doneWithPicker))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneWithPicker))
        
        doneButtonBar.setItems([flexible, doneButton], animated: true)
        
        foodTimeField.inputAccessoryView = doneButtonBar
        foodTimeField.inputView = foodTimePicker
        
        foodTimePicker.datePickerMode = .time
    }
    
    @objc private func doneWithPicker(){
        foodTimeField.text = ModelController().formatDateToHHmm(date: foodTimePicker.date)
        self.view.endEditing(true)
    }
    
    @objc private func doneWithKeypad(){
        view.endEditing(true)
    }
    
    //MARK: - Favourite buttons
    ///Toggle between favourite and daily log views
    @IBAction private func toggleFavourites(_ sender: Any) {
        if self.showFavouritesFood == false{
            showFavouritesFood = true
            selectedCellIndexPath = []
        }
        else{
            showFavouritesFood = false
        }
    }
    
    //TODO: Add a way to remove favourites
    ///Delegate function to toggle whether a meal is favourited
    func didPressButton(_ tag: Int) {
        if showFavouritesFood != true{
            let toFav = loggedMeals[tag]
            ModelController().toggleFavouriteFood(item: toFav)
            updateTable()
        }
    }
    
    //MARK: - Table functions
    ///Table funcion to set number of rows equal to total meals
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loggedMeals.count
    }
    
    ///Provides setup for table cells, setting each label
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        cell.cellDelegate = self
        cell.tag = indexPath.row
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = #colorLiteral(red: 0.9455107252, green: 0.9455107252, blue: 0.9455107252, alpha: 1)
        cell.selectedBackgroundView = backgroundView
        
        let currentMeal = loggedMeals[indexPath.row]
        
        cell.loggedFoodName.text = currentMeal.name
        cell.loggedFoodTime.text = currentMeal.time
        cell.loggedFoodCarbs.text = "\(currentMeal.carbs)g"
        cell.loggedFoodProtein.text = "\(currentMeal.protein)g"
        cell.loggedFoodFat.text = "\(currentMeal.fat)g"
        
        
        if ModelController().itemInFavouritesFood(item: currentMeal){
            cell.favouriteFoodButton.tintColor = #colorLiteral(red: 0.9764705882, green: 0.6235294118, blue: 0.2196078431, alpha: 1)
        }
        else{
            cell.favouriteFoodButton.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        }
        
        if showFavouritesFood == true{
            cell.loggedFoodTime.isHidden = true
            cell.loggedFoodFat.isHidden = true
            cell.loggedFoodProtein.isHidden = true
            cell.loggedFoodCarbs.isHidden = true
        }
        else{
            cell.loggedFoodTime.isHidden = false
            cell.loggedFoodFat.isHidden = false
            cell.loggedFoodProtein.isHidden = false
            cell.loggedFoodCarbs.isHidden = false
        }

        return(cell)
    }
    
    ///Allows selecting a favourite to add to daily log if showing favourites, else toggles expanding of cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        if showFavouritesFood == true{
            foodNameTextField.text = loggedMeals[indexPath.row].name
            foodTimeField.text = dateFormatter.string(from: Date())
            carbsTextField.text = String(loggedMeals[indexPath.row].carbs)
            proteinTextField.text = String(loggedMeals[indexPath.row].protein)
            fatTextField.text = String(loggedMeals[indexPath.row].fat)
        }
        else if selectedCellIndexPath.contains(indexPath){
            selectedCellIndexPath = selectedCellIndexPath.filter() { $0 != indexPath }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        else{
            selectedCellIndexPath.append(indexPath)
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    ///Allows expanding of cells by changing cell height for specific rows
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedCellIndexPath.contains(indexPath) {
            return selectedCellHeight
        }
        return unselectedCellHeight
    }
    
    ///Updates the table by re-fetching either a list of meals for that day, or the user's favourites
    private func updateTable(){
        if showFavouritesFood == true{
            let loggedMeals = ModelController().fetchFavouritesFood()
            self.loggedMeals = loggedMeals
        }
        else{
            let loggedMeals = ModelController().fetchMeals(day: currentDay)
            self.loggedMeals = loggedMeals
        }
        self.foodLogTable.reloadData()
    }

    //MARK: - Add food button
    ///Calls ModelController function addMeal with contents of data entry fields, if they are all filled
    @IBAction private func addFoodToLog(_ sender: Any) {

        if ((foodNameTextField.text != "") && (foodTimeField.text != "") && (carbsTextField.text != "") && (proteinTextField.text != "") && (fatTextField.text != "")){
            ModelController().addMeal(
                    name: foodNameTextField.text!,
                    time: foodTimeField.text!,
                    date: currentDay,
                    carbs: Int32((Double(carbsTextField.text!)?.rounded())!),
                    fat: Int32((Double(fatTextField.text!)?.rounded())!),
                    protein: Int32((Double(proteinTextField.text!)?.rounded())!))
            showFavouritesFood = false
            
            foodNameTextField.text = ""
            foodTimeField.text = ""
            carbsTextField.text = ""
            proteinTextField.text = ""
            fatTextField.text = ""
        }
    }
}


