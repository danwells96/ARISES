//
//  ViewControllerFood.swift
//  ARISES
//
//  Created by Ryan Armiger on 16/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ViewControllerFood: UIViewController, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    //TODO: food log not working
 
    //MARK: Properties
    @IBOutlet weak var foodTimeField: UITextField!
    @IBOutlet weak var foodLogTable: UITableView!
    @IBOutlet weak var carbsTextField: UITextField!
    @IBOutlet weak var proteinTextField: UITextField!
    @IBOutlet weak var fatTextField: UITextField!
    @IBOutlet weak var foodNameTextField: UITextField!
    
    //defining picker related variables
    var foodTimePicker = UIDatePicker()
    
    //defining table related variables
    var loggedMeals = [Meals]()
    var favouriteMeals = [Meals]()
    var expanded = false
    
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
        
        let fetchRequest: NSFetchRequest<Meals> = Meals.fetchRequest()
        
        do{
            let loggedMeals = try PersistenceService.context.fetch(fetchRequest)
            self.loggedMeals = loggedMeals
            self.foodLogTable.reloadData()
        } catch{}
        
    }
    
    //MARK: Picker functions
    //Food Time picker
    func createFoodTimePicker(){
        
        let doneButtonBar = UIToolbar()
        doneButtonBar.sizeToFit()
        
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: #selector(doneWithPicker))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneWithPicker))
        
        doneButtonBar.setItems([flexible, doneButton], animated: true)
        
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
    
    //MARK: Table functions

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loggedMeals.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   //     let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell; cell.set(content: loggedMeals[indexPath.row])
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell

        let currentMeal = loggedMeals[indexPath.row]
        cell.loggedFoodName.text = currentMeal.name
        cell.loggedFoodTime.text = currentMeal.time
    
        return(cell)
    }
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        _ = loggedMeals[indexPath.row]
        expanded = !expanded
        foodLogTable.reloadRows(at: [indexPath], with: .automatic)
    
    }
    */
    
    
    @objc func doneWithKeypad(){
        view.endEditing(true)
    }
    
    @IBAction func addFoodToLog(_ sender: Any) {

        if ((foodNameTextField.text != "") && (foodTimeField.text != "") && (carbsTextField.text != "") && (proteinTextField.text != "") && (fatTextField.text != "")){
            let newMeal = Meals(context: PersistenceService.context)
            newMeal.name = foodNameTextField.text
            newMeal.time = foodTimeField.text
            newMeal.carbs = Int32(carbsTextField.text!)!
            newMeal.protein = Int32(proteinTextField.text!)!
            newMeal.fat = Int32(fatTextField.text!)!
            PersistenceService.saveContext()
            self.loggedMeals.append(newMeal)
            self.foodLogTable.reloadData()
        
            foodNameTextField.text = ""
            foodTimeField.text = ""
            carbsTextField.text = ""
            proteinTextField.text = ""
            fatTextField.text = ""
        }
    }

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
