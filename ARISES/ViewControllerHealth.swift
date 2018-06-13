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

    @IBOutlet weak var favouritesButton: UIButton!
    @IBOutlet weak var stressSwitch: UISwitch!
    @IBOutlet weak var illnessSwitch: UISwitch!
    

    
    @IBOutlet weak var healthLogTable: UITableView!
    @IBOutlet weak var filterHypoOutlet: UIButton!
    @IBOutlet weak var filterHyperOutlet: UIButton!
    @IBOutlet weak var filterExerciseOutlet: UIButton!
    @IBOutlet weak var filterStressOutlet: UIButton!
    @IBOutlet weak var filterIllnessOutlet: UIButton!
    
    @IBOutlet weak var sevenDaysOutlet: UIButton!
    @IBOutlet weak var thirtyDaysOutlet: UIButton!
    @IBOutlet weak var sixtyDaysOutlet: UIButton!
    
    
    var selectedCellIndexPath = [IndexPath?]()
    let selectedCellHeight: CGFloat = 89.0
    let unselectedCellHeight: CGFloat = 40.0
    private var daysToShow = "seven"{
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
            self.updateTable()

        }
    }
    private var filterHypo = false{
        didSet{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
                self.updateTable()
            }
        }
    }
    private var filterExercise = false{
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
    private var filterStress = false{
        didSet{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
                self.updateTable()
            }
        }
    }
    private var filterIllness = false{
        didSet{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
                self.updateTable()
            }
        }
    }
    private var loggedDays = [Day]()
    private var stressStart: Date? = nil
    private var illnessStart: Date? = nil


    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()

        favouritesButton.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        
        daysToShow = "seven"
        showFavouritesHealth = false
        stressSwitch.onTintColor = #colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1)
        illnessSwitch.onTintColor = #colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1)
        stressSwitch.setOn(false, animated: true)
        illnessSwitch.setOn(false, animated: true)
        

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
    @IBAction func filterExerciseButton(_ sender: Any) {
        if filterExercise == false{
            filterExercise = true
            filterExerciseOutlet.setTitleColor(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), for: .normal)
        }
        else {
            filterExercise = false
            filterExerciseOutlet.setTitleColor(#colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1), for: .normal)
        }
    }
    @IBAction func filterStressButton(_ sender: Any) {
        if filterStress == false{
            filterStress = true
            filterStressOutlet.setTitleColor(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), for: .normal)
        }
        else {
            filterStress = false
            filterStressOutlet.setTitleColor(#colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1), for: .normal)
        }
    }
    @IBAction func filterIllnessButton(_ sender: Any) {
        if filterIllness == false{
            filterIllness = true
            filterIllnessOutlet.setTitleColor(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), for: .normal)
        }
        else {
            filterIllness = false
            filterIllnessOutlet.setTitleColor(#colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1), for: .normal)
        }
    }
    

    @IBAction func stressSwitchButton(_ sender: Any) {
        //May crash if turned off but never turned on. Shouldn't be possible though.
        if stressSwitch.isOn{
            stressStart = Date()
        }
        else{
            ModelController().addStress(start: stressStart!, end: Date())
            stressStart = nil
        }
    }

    @IBAction func illnessSwitchButton(_ sender: Any) {
        if illnessSwitch.isOn{
            illnessStart = Date()
        }
        else{
            ModelController().addIllness(start: illnessStart!, end: Date())
            illnessStart = nil
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
            self.daysToShow = "seven"

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
    
    func didPressViewDayButton(_ tag: Int) {
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("setDay"), object: (loggedDays[tag].date)!)
    }
    
    
    
    func didPressCameraButton(_tag: Int){
        print("incomplete functionality")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loggedDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!ViewControllerTableViewCell
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = #colorLiteral(red: 0.9455107252, green: 0.9455107252, blue: 0.9455107252, alpha: 1)
        cell.selectedBackgroundView = backgroundView
        
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
        if let glucStats = currentDay.glucoseStats{
            cell.loggedHealthLowLabel.text = "\(glucStats.low)"
            cell.loggedHealthAvgLabel.text = "\(glucStats.average)"
            cell.loggedHealthHighLabel.text = "\(glucStats.high)"
        }
        else{
            cell.loggedHealthLowLabel.text = "N/A"
            cell.loggedHealthAvgLabel.text = "N/A"
            cell.loggedHealthHighLabel.text = "N/A"
        }
        
    
        //ICONS highlighting
        if (currentDay.glucoseTags?.contains("Hypo")) != nil {
            cell.loggedHealthHypoIcon.tintColor = #colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1)
        }
        else {
            cell.loggedHealthHypoIcon.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        }
        if (currentDay.glucoseTags?.contains("Hyper")) != nil {
            cell.loggedHealthHyperIcon.tintColor = #colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1)
        }
        else {
            cell.loggedHealthHyperIcon.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        }
        if currentDay.exercise?.count != 0{
            cell.loggedHealthExerciseIcon.tintColor = #colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1)
        }
        else {
            cell.loggedHealthExerciseIcon.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        }
        if currentDay.stress?.count != 0{
            cell.loggedHealthStressedIcon.tintColor = #colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1)
        }
        else {
            cell.loggedHealthStressedIcon.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        }
        if currentDay.illness?.count != 0{
            cell.loggedHealthIllnessIcon.tintColor = #colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1)
        }
        else {
            cell.loggedHealthIllnessIcon.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
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
        if filterExercise == true{
            loggedDays = loggedDays.filter({ (Day) -> Bool in
                Day.exercise?.anyObject() != nil
            })
        }
        if filterStress == true{
            loggedDays = loggedDays.filter({ (Day) -> Bool in
                Day.stress?.anyObject() != nil
            })
        }
        if filterIllness == true{
            loggedDays = loggedDays.filter({ (Day) -> Bool in
                Day.illness?.anyObject() != nil
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
 
}
