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
    

    //TODO: solve keyboard covering name in some phones
    //TODO: Auto layout table cells
    
    //MARK: - Properties
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
    //Variable tracking state of favourites views
    private var showFavourites = false{
        didSet{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                if self.showFavourites == false{
                    self.favouritesButton.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
                }
                else{
                    self.favouritesButton.tintColor = #colorLiteral(red: 0.9764705882, green: 0.6235294118, blue: 0.2196078431, alpha: 1)
                }
                self.updateTable()
            }
        }
    }

    //var expanded: Bool = false
    //var selection: IndexPath?
    //private var height: CGFloat = 40
    

    //MARK: - Override
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
    
    //MARK: - Picker functions
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

        foodTimeField.text = ModelController().formatDateToTime(date: foodTimePicker.date)
        self.view.endEditing(true)
    }
    
    @objc private func doneWithKeypad(){
        view.endEditing(true)
    }
    
    //MARK: - Favourite buttons
    //Toggle between favourite and daily log views
    @IBAction func toggleFavourites(_ sender: Any) {
        if self.showFavourites == false{
            showFavourites = true
        }
        else{
            showFavourites = false
        }
        //Testing day computed properties
    /*    let curDay = ModelController().findOrMakeDay(day: Date())
        print("\(String(describing: curDay.glucoseTags))")
 */
    }
    
    //TODO: Either add remove buttons in expanded or allow a way to remove favourites
    func didPressButton(_ tag: Int) {
        if showFavourites != true{
            let toFav = loggedMeals[tag]
            //print("I have toggled \(toFav.name!)")
            ModelController().toggleFavourite(item: toFav)
            updateTable()
        }
    }
    //MARK: - Table functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loggedMeals.count
    }
    
    //Provides "setup" for cell
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
        
        if showFavourites == true{
            cell.loggedFoodTime.isHidden = true
            //cell.loggedFoodTime.text = "Select"
            //cell.loggedFoodTime.textColor = #colorLiteral(red: 0.9764705882, green: 0.6235294118, blue: 0.2196078431, alpha: 1)
        }
        else{
            cell.loggedFoodTime.isHidden = false

        }
        
        
        return(cell)
    }
    
    //Allows selecting a favourite to add to daily log
    //Will likely be replaced with a button to select and used for expanding
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if showFavourites == true{
            ModelController().addMeal(
                name: loggedMeals[indexPath.row].name!,
                time: ModelController().formatDateToTime(date: Date()),
                date: Date(),
                carbs: loggedMeals[indexPath.row].carbs,
                fat: loggedMeals[indexPath.row].fat,
                protein: loggedMeals[indexPath.row].protein)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { //??Is this delay?
                self.showFavourites = false
            }
        }
    }
    
    /*
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
        if showFavourites == true{
            let loggedMeals = ModelController().fetchFavourites()
            self.loggedMeals = loggedMeals
            self.foodLogTable.reloadData()
        }
        else{
            let loggedMeals = ModelController().fetchMeals(day: Date())
            self.loggedMeals = loggedMeals
            self.foodLogTable.reloadData()
        }
        /*
         //testing computed variables
        for index in loggedMeals{
            if index.day?.low != nil{
                print("\(index.day?.low)")
            }
        }
 */
 
    }

    //MARK: - Add food button
    @IBAction func addFoodToLog(_ sender: Any) {

        if ((foodNameTextField.text != "") && (foodTimeField.text != "") && (carbsTextField.text != "") && (proteinTextField.text != "") && (fatTextField.text != "")){
    
            ModelController().addMeal(
                    name: foodNameTextField.text!,
                    time: foodTimeField.text!,
                    date: Date(),
                    carbs: Int32(carbsTextField.text!)!,
                    fat: Int32(fatTextField.text!)!,
                    protein: Int32(proteinTextField.text!)!)
            showFavourites = false
            
            foodNameTextField.text = ""
            foodTimeField.text = ""
            carbsTextField.text = ""
            proteinTextField.text = ""
            fatTextField.text = ""
        }
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
}
