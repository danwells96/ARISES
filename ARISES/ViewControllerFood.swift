//
//  ViewControllerFood.swift
//  ARISES
//
//  Created by Ryan Armiger on 16/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerFood: UIViewController, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate, tableCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

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
    private var expanded = false
    var selectedCellIndexPath = [IndexPath?]()
    let selectedCellHeight: CGFloat = 89.0
    let unselectedCellHeight: CGFloat = 40.0
    //Variable tracking state of favourites views
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

        foodTimeField.text = ModelController().formatDateToHHmm(date: foodTimePicker.date)
        self.view.endEditing(true)
    }
    
    @objc private func doneWithKeypad(){
        view.endEditing(true)
    }
    
    //MARK: - Favourite buttons
    //Toggle between favourite and daily log views
    @IBAction func toggleFavourites(_ sender: Any) {
        if self.showFavouritesFood == false{
            showFavouritesFood = true
            selectedCellIndexPath = []
        }
        else{
            showFavouritesFood = false
        }
        //Testing day computed properties
    /*    let curDay = ModelController().findOrMakeDay(day: Date())
        print("\(String(describing: curDay.glucoseTags))")
 */
    }
    
    //TODO: Either add remove buttons in expanded or allow a way to remove favourites
    func didPressButton(_ tag: Int) {
        if showFavouritesFood != true{
            let toFav = loggedMeals[tag]
            //print("I have toggled \(toFav.name!)")
            ModelController().toggleFavouriteFood(item: toFav)
            updateTable()
        }
    }
    
    func didPressCameraButton(_tag: Int){
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .camera
        
        present(picker, animated: true, completion: nil)
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
            //cell.loggedFoodTime.text = "Select"
            //cell.loggedFoodTime.textColor = #colorLiteral(red: 0.9764705882, green: 0.6235294118, blue: 0.2196078431, alpha: 1)
        }
        else{
            cell.loggedFoodTime.isHidden = false
            cell.loggedFoodFat.isHidden = false
            cell.loggedFoodProtein.isHidden = false
            cell.loggedFoodCarbs.isHidden = false
        }

        return(cell)
    }
    
    //Allows selecting a favourite to add to daily log
    //Will likely be replaced with a button to select and used for expanding
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        //(dateFormatter.date(from: "\(Date())"))!
        if showFavouritesFood == true{
            ModelController().addMeal(
                name: loggedMeals[indexPath.row].name!,
                time: ModelController().formatDateToTime(date: Date()),
                date: Date(),
                carbs: loggedMeals[indexPath.row].carbs,
                fat: loggedMeals[indexPath.row].fat,
                protein: loggedMeals[indexPath.row].protein)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { 
                self.showFavouritesFood = false
            }
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedCellIndexPath.contains(indexPath) {
            return selectedCellHeight
        }
        return unselectedCellHeight
    }
    
    private func updateTable(){
        if showFavouritesFood == true{
            let loggedMeals = ModelController().fetchFavouritesFood()
            self.loggedMeals = loggedMeals
        }
        else{
            let loggedMeals = ModelController().fetchMeals(day: Date())
            self.loggedMeals = loggedMeals
        }
        self.foodLogTable.reloadData()
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
            showFavouritesFood = false
            
            foodNameTextField.text = ""
            foodTimeField.text = ""
            carbsTextField.text = ""
            proteinTextField.text = ""
            fatTextField.text = ""
        }
    }

}
