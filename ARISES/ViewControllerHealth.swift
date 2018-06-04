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

class ViewControllerHealth: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
 /*   class ViewControllerHealth: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {*/
 /*
    //MARK: Properties
    @IBOutlet weak var stressField: UITextField!
    
    //defining picker related variables
    let stressLevel = ["not", "a little", "quite", "very"]
    var stressPicker = UIPickerView()
   */
    
    @IBOutlet weak var healthLogTable: UITableView!
    var selectedCellIndexPath = [IndexPath?]()
    let selectedCellHeight: CGFloat = 89.0
    let unselectedCellHeight: CGFloat = 40.0
    private var sumExercise = 0
    private var daysToShow = "none"{
        didSet{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
                self.updateTable()
            }
        }
    }

    private var loggedDays = [Day]()
    private var loggedExercise = [Exercise]()
    private var loggedExerciseTotals = [Int]()
    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
  /*
        stressPicker.delegate = self
        stressPicker.dataSource = self
        stressField.inputView = stressPicker*/
        
        updateTable()
    }
        
    @IBAction func sevenDaysButton(_ sender: UIButton) {
        daysToShow  = "seven"
    }
    
    @IBAction func thirtyDaysButton(_ sender: UIButton) {
        daysToShow = "thirty"
    }
    
    @IBAction func sixtyDaysButton(_ sender: UIButton) {
        daysToShow = "sixty"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loggedDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!ViewControllerTableViewCell
        
        let currentDay = loggedDays[indexPath.row]
        cell.dateInLog.text = currentDay.date
        //find day exercise
        
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
        
        //ATTEMPTS TO FIND TOTAL EXERCISE
     /*   for index1 in loggedDays {
         
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss.SSSSxxx"
            guard let date = dateFormatter.date(from: index1.date!) else {
                fatalError("ERROR: Date conversion failed due to mismatched format.")
            }
            var loggedExercise = ModelController().fetchExercise(day: date)
            for index2 in loggedExercise {
                let currentExercise = loggedExercise[index2]
                sumExercise += currentExercise.duration
            }
            loggedExerciseTotals.append(sumExercise)
        }*/
        
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
