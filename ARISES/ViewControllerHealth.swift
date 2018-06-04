//
//  ViewControllerHealth.swift
//  ARISES
//
//  Created by Ryan Armiger on 16/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ViewControllerHealth: UIViewController, UITableViewDataSource, UITableViewDelegate, tableCellDelegate{
    
 /*   class ViewControllerHealth: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {*/
 /*
    //MARK: Properties
    @IBOutlet weak var stressField: UITextField!
    
    //defining picker related variables
    let stressLevel = ["not", "a little", "quite", "very"]
    var stressPicker = UIPickerView()
   */
    @IBOutlet weak var favouritesButton: UIButton!
    
    @IBOutlet weak var healthLogTable: UITableView!
    @IBOutlet weak var filterHypoOutlet: UIButton!
    @IBOutlet weak var filterHyperOutlet: UIButton!
    
    @IBOutlet weak var sevenDaysOutlet: UIButton!
    @IBOutlet weak var thirtyDaysOutlet: UIButton!
    @IBOutlet weak var sixtyDaysOutlet: UIButton!
    
    
    var selectedCellIndexPath = [IndexPath?]()
    let selectedCellHeight: CGFloat = 89.0
    let unselectedCellHeight: CGFloat = 40.0
    private var daysToShow = "none"{
        didSet{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
                
                if self.daysToShow == "seven"{
                    self.sevenDaysOutlet.setTitleColor(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), for: .normal)
                    self.thirtyDaysOutlet.setTitleColor(#colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1), for: .normal)
                    self.sixtyDaysOutlet.setTitleColor(#colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1), for: .normal)
                }
                else if self.daysToShow == "thirty"{
                    self.sevenDaysOutlet.setTitleColor(#colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1), for: .normal)
                    self.thirtyDaysOutlet.setTitleColor(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), for: .normal)
                    self.sixtyDaysOutlet.setTitleColor(#colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1), for: .normal)
                }
                else if self.daysToShow == "sixty"{
                    self.sevenDaysOutlet.setTitleColor(#colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1), for: .normal)
                    self.thirtyDaysOutlet.setTitleColor(#colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1), for: .normal)
                    self.sixtyDaysOutlet.setTitleColor(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), for: .normal)
                }
                else if self.daysToShow == "none"{
                    self.sevenDaysOutlet.setTitleColor(#colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1), for: .normal)
                    self.thirtyDaysOutlet.setTitleColor(#colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1), for: .normal)
                    self.sixtyDaysOutlet.setTitleColor(#colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1), for: .normal)
                }
                self.updateTable()
            }
        }
    }
    private var showFavouritesHealth = false{
        didSet{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                if self.showFavouritesHealth == false{
                    self.favouritesButton.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
                }
                else{
                    self.favouritesButton.tintColor = #colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1)
                }
            }
        }
    }
    private var filterHypo = false{
        didSet{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
                self.updateTable()
            }
        }
    }
    private var filterHyper = false{
        didSet{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
                self.updateTable()
            }
        }
    }
    private var loggedDays = [Day]()
    //private var loggedExercise = [Exercise]()
   // private var loggedExerciseTotals = [Int]()
    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
  /*
        stressPicker.delegate = self
        stressPicker.dataSource = self
        stressField.inputView = stressPicker*/
        favouritesButton.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)

        updateTable()
    }
        
    @IBAction func sevenDaysButton(_ sender: UIButton) {
        daysToShow  = "seven"
        showFavouritesHealth = false
    }
    
    @IBAction func thirtyDaysButton(_ sender: UIButton) {
        daysToShow = "thirty"
        showFavouritesHealth = false

    }
    
    @IBAction func sixtyDaysButton(_ sender: UIButton) {
        daysToShow = "sixty"
        showFavouritesHealth = false

    }

    @IBAction func filterHypoButton(_ sender: Any) {
        if filterHypo == false{
            filterHypo = true
            filterHypoOutlet.setTitleColor(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), for: .normal)
        }
        else {
            filterHypo = false
            filterHypoOutlet.setTitleColor(#colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1), for: .normal)

        }
    }
    @IBAction func filterHyperButton(_ sender: Any) {
        if filterHyper == false{
            filterHyper = true
            filterHyperOutlet.setTitleColor(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), for: .normal)
        }
        else {
            filterHyper = false
            filterHyperOutlet.setTitleColor(#colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1), for: .normal)
        }
    }
    
    //MARK: - Favourite buttons
    //Toggle between favourite and daily log views
    @IBAction func toggleFavourites(_ sender: Any) {
        if self.showFavouritesHealth == false{
            showFavouritesHealth = true
            selectedCellIndexPath = []
            self.daysToShow = "none"

        }
        else{
            showFavouritesHealth = false
        }
    }
    
  
    func didPressButton(_ tag: Int) {
        if showFavouritesHealth != true{
            let toFav = loggedDays[tag]
            //print("I have toggled \(toFav.name!)")
            ModelController().toggleFavouriteDay(item: toFav)
            updateTable()
        }
    }
    
    func didPressCameraButton(_tag: Int){
        print("incomplete functionality")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loggedDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!ViewControllerTableViewCell
        
        cell.cellDelegate = self
        cell.tag = indexPath.row
        
        let currentDay = loggedDays[indexPath.row]
        cell.dateInLog.text = currentDay.date
        
        if ModelController().itemInFavouritesDay(item: currentDay){
            cell.favouriteHealthButton.tintColor = #colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1)
        }
        else{
            cell.favouriteHealthButton.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        }
        
        if (currentDay.glucoseTags?.contains("Hypo")) != nil {
            cell.healthLogHypo.text = "Hypo"
        }
        else {
            cell.healthLogHypo.text = ""
        }
        if (currentDay.glucoseTags?.contains("Hyper")) != nil {
            cell.healthLogHyper.text = "Hyper"
        }
        else {
            cell.healthLogHyper.text = ""
        }
        if currentDay.exercise?.count != nil{
            cell.healthLogExercise.text = "\((currentDay.exercise?.count)!)"
        }
        else{
            cell.healthLogExercise.text = "0"
        }

        return(cell)
    }
    
    private func updateTable(){
        if showFavouritesHealth == true{
            let loggedDays = ModelController().fetchFavouritesDays()
            self.loggedDays = loggedDays
            //daysToShow = "none"
        }
        else{
            if(daysToShow == "seven"){
                let loggedDays = ModelController().fetchDay(degreeOfTimeTravel: -7)
                self.loggedDays = loggedDays
            }
            else if(daysToShow == "thirty"){
                let loggedDays = ModelController().fetchDay(degreeOfTimeTravel: -30)
                self.loggedDays = loggedDays
            }
            else if(daysToShow == "sixty"){
                let loggedDays = ModelController().fetchDay(degreeOfTimeTravel: -60)
                self.loggedDays = loggedDays
            }
        }
        //Filter based on tags
        if filterHypo == true{
            loggedDays = loggedDays.filter({ (Day) -> Bool in
                Day.glucoseTags?.contains("Hypo") != nil
            })
        }
        if filterHyper == true{
            loggedDays = loggedDays.filter({ (Day) -> Bool in
                Day.glucoseTags?.contains("Hyper") != nil
            })
        }

        self.healthLogTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedCellIndexPath.contains(indexPath){
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
    
    //MARK: Picker functions
    //Word Pickers: exercise intensity and stress
   /* public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component:Int) -> Int{
        return stressLevel.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return stressLevel[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        stressField.text = stressLevel[row]
        stressField.resignFirstResponder()
    }
    */
    
}
