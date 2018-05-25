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
    var Testdates = [Day]()
   // var expanded: Bool = false
    
  /*  private var height: CGFloat = 44
    {
        didSet
        {
            self.foodLogTable.rowHeight = height
        }
    }*/
    
    
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
        
        updateTable()

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

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell

        let currentMeal = loggedMeals[indexPath.row]
        cell.loggedFoodName.text = currentMeal.name
        cell.loggedFoodTime.text = currentMeal.time
        cell.loggedFoodCarbs.text = "\(currentMeal.carbs)"
       // print("current meal date is \(currentMeal.day?.date)")
        return(cell)
    }
    
    private func updateTable(){
        let fetchRequest: NSFetchRequest<Meals> = Meals.fetchRequest()
        
        do{
            let loggedMeals = try PersistenceService.context.fetch(fetchRequest)
            self.loggedMeals = loggedMeals
            self.foodLogTable.reloadData()
        } catch{}
        
    }
    @objc func doneWithKeypad(){
        view.endEditing(true)
    }
    
    @IBAction func addFoodToLog(_ sender: Any) {

        if ((foodNameTextField.text != "") && (foodTimeField.text != "") && (carbsTextField.text != "") && (proteinTextField.text != "") && (fatTextField.text != "")){
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .none
            /*
            let newMeal = Meals(context: PersistenceService.context)
            newMeal.name = foodNameTextField.text
            newMeal.time = foodTimeField.text
            newMeal.carbs = Int32(carbsTextField.text!)!
            newMeal.protein = Int32(proteinTextField.text!)!
            newMeal.fat = Int32(fatTextField.text!)!
            let newDay = Day(context: PersistenceService.context)
            newDay.date = dateFormatter.string(from: Date())
            newDay.addToMeals(newMeal)
            PersistenceService.saveContext()
            */
            
            
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
        let dateFetch: NSFetchRequest<Day> = Day.fetchRequest()
        
        let checkDates = try? PersistenceService.context.fetch(dateFetch)
        print("number of dates is \(checkDates!.count)")

        for Day in checkDates!{
            print("\(Day.date)")
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
