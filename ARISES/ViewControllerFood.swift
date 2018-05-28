//
//  ViewControllerFood.swift
//  ARISES
//
//  Created by Ryan Armiger on 16/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerFood: UIViewController, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate, tableCellDelegate {
    

    //MARK: Properties
    @IBOutlet weak var foodTimeField: UITextField!
    @IBOutlet weak var foodLogTable: UITableView!
    @IBOutlet weak var carbsTextField: UITextField!
    @IBOutlet weak var proteinTextField: UITextField!
    @IBOutlet weak var fatTextField: UITextField!
    @IBOutlet weak var foodNameTextField: UITextField!
    //defining picker related variables
    private var foodTimePicker = UIDatePicker()
    
    @IBOutlet weak var favouritesButton: UIButton!
    //defining table related variables
    private var loggedMeals = [Meals]()
    private var showFavourites = false
    //private var favouriteMeals = [Meals]()
    //var expanded: Bool = false
    //var selection: IndexPath?
    //private var height: CGFloat = 40
    
    
    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        foodLogTable.dataSource = self
        foodLogTable.delegate = self
        
        createFoodTimePicker()
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneWithKeypad))
        
        toolBar.setItems([flexible, doneButton], animated: true)
        
        carbsTextField.inputAccessoryView = toolBar
        proteinTextField.inputAccessoryView = toolBar
        fatTextField.inputAccessoryView = toolBar
        foodNameTextField.inputAccessoryView = toolBar
        
        favouritesButton.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        updateTable()

    }
    
    //MARK: Picker functions
    //Food Time picker
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        foodTimeField.text = dateFormatter.string(from: foodTimePicker.date)
        self.view.endEditing(true)
    }
    
    //MARK: Table functions
    //TODO: rename function and redo outlet
    @IBAction func testFav(_ sender: Any) {
        if self.showFavourites == false{
            favouritesButton.tintColor = #colorLiteral(red: 0.9764705882, green: 0.6235294118, blue: 0.2196078431, alpha: 1)
            showFavourites = true
        }
        else{
            favouritesButton.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            showFavourites = false
        }
        updateTable()
        //Test printouts
        let favMeals = ModelController().fetchFavourites()
        for index in favMeals{
            print("\(index.name!)")
        }
    }
    func didPressButton(_ tag: Int) {
        let toFav = loggedMeals[tag]
        print("I have toggled \(toFav.name!)")
        ModelController().toggleFavourite(item: toFav)
        updateTable()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loggedMeals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        cell.cellDelegate = self
        cell.tag = indexPath.row
        
        let currentMeal = loggedMeals[indexPath.row]
        
        cell.loggedFoodName.text = currentMeal.name
        cell.loggedFoodTime.text = currentMeal.time
        cell.loggedFoodCarbs.text = "\(currentMeal.carbs)"
        
        if ModelController().itemInFavourites(item: currentMeal){
            cell.favouriteFoodButton.tintColor = #colorLiteral(red: 0.9764705882, green: 0.6235294118, blue: 0.2196078431, alpha: 1)
        }
        else{
            cell.favouriteFoodButton.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        }
        
        return(cell)
    }
    
  /*  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection = self.foodLogTable.indexPathForSelectedRow
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt selection: IndexPath) -> CGFloat {
        if(expanded == false){
            expanded = true

            return 90
        }
        else{
            expanded = false
            return 40
        }
    }*/
    
    private func updateTable(){
        //TODO: swap order of if else
        if showFavourites == false{
            let loggedMeals = ModelController().fetchMeals(day: Date())
            self.loggedMeals = loggedMeals
            self.foodLogTable.reloadData()
        }
        else{
            let loggedMeals = ModelController().fetchFavourites()
            self.loggedMeals = loggedMeals
            self.foodLogTable.reloadData()
        }
    }
    @objc private func doneWithKeypad(){
        view.endEditing(true)
    }
    
    @IBAction func addFoodToLog(_ sender: Any) {

        if ((foodNameTextField.text != "") && (foodTimeField.text != "") && (carbsTextField.text != "") && (proteinTextField.text != "") && (fatTextField.text != "")){
    
            ModelController().addMeal(
                    name: foodNameTextField.text!,
                    time: foodTimeField.text!,
                    date: Date(),
                    carbs: Int32(carbsTextField.text!)!,
                    fat: Int32(fatTextField.text!)!,
                    protein: Int32(proteinTextField.text!)!)
            updateTable()
        
            foodNameTextField.text = ""
            foodTimeField.text = ""
            carbsTextField.text = ""
            proteinTextField.text = ""
            fatTextField.text = ""
            
            
        }
        /*
        //Test printouts of date information
        let dateFetch: NSFetchRequest<Day> = Day.fetchRequest()
        
        let checkDates = try? PersistenceService.context.fetch(dateFetch)
        print("number of dates is \(checkDates!.count)")

        for Day in checkDates!{
            print("\(Day.date)")
        }
        */
    }
    
 /*   @IBAction func expandFoodCell(_ sender: Any) {
        if(expanded == false){
            height = 90
            expanded = true
        }
        else{
            height = 44
            expanded = false
        }
        
    }*/

   /* @IBAction func favouriteButton(_ sender: Any) {
        let newFavourite = loggedMeals[GAH]
        favouriteMeals.append(Meal(Name: "\(newFavourite.Name)", Time: "\(newFavourite.Time)", Carbs: Int(newFavourite.Carbs)!, Protein: Int(newFavourite.Protein)!, Fat: Int(newFavourite.Fat)!))
    }
    */
   
    /*@IBAction func chooseFromFavourites(_ sender: Any) {
        //segue to a new cell design containing the list of favourites
        let selectedMeal = favouriteMeals[GAH]
        foodNameTextField.text = "\(selectedMeal.Name)"
        foodTimeField.text = "\(selectedMeal.Time)"
        carbsTextField.text = "\(selectedMeal.Carbs)"
        proteinTextField.text = "\(selectedMeal.Protein)"
        fatTextField.text = "\(selectedMeal.Fat)"
    }*/
    
}
