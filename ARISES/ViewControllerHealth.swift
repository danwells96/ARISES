//
//  ViewControllerHealth.swift
//  ARISES
//
//  Created by Ryan Armiger on 16/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import CoreData
import UIKit

class ViewControllerHealth: UIViewController, UITableViewDataSource, UITableViewDelegate, tableCellDelegate{

    //MARK: - Outlets
    @IBOutlet weak var favouritesButton: UIButton!
    @IBOutlet weak var stressSwitch: UISwitch!
    @IBOutlet weak var illnessSwitch: UISwitch!
    @IBOutlet weak var healthLogTable: UITableView!
    @IBOutlet weak var filterHypoOutlet: UIButton!
    @IBOutlet weak var filterHyperOutlet: UIButton!
    @IBOutlet weak var filterExerciseOutlet: UIButton!
    @IBOutlet weak var filterStressOutlet: UIButton!
    @IBOutlet weak var filterIllnessOutlet: UIButton!
    @IBOutlet weak var illnessLabel: UILabel!
    @IBOutlet weak var stressLabel: UILabel!
    @IBOutlet weak var sevenDaysOutlet: UIButton!
    @IBOutlet weak var thirtyDaysOutlet: UIButton!
    @IBOutlet weak var sixtyDaysOutlet: UIButton!
    
    //MARK: - Properties
    //Table properties
    private var selectedCellIndexPath = [IndexPath?]()
    private let selectedCellHeight: CGFloat = 89.0
    private let unselectedCellHeight: CGFloat = 40.0
    
    ///Tracks whether to show favourites or daily log
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
    
    //Filter button properties
    ///Allows user to choose previous 7, 30 or 60 days to view, adjusts button colours to show selection and updates the table
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
    
    //Table properites
    ///Stores an array of fetched Day objects to display in table
    private var loggedDays = [Day]()
    ///Tracks start times of stress tracking to allow storing of stress logs with duration
    private var stressStart: Date? = nil
    ///Tracks start times of illness tracking to allow storing of illness logs with duration
    private var illnessStart: Date? = nil

    ///Tracks date set by graph and hides data entry fields when not on current day
    private var currentDay = Date(){
        didSet{
            
            if currentDay != Calendar.current.startOfDay(for: Date()) {
                stressLabel.isHidden = true
                illnessLabel.isHidden = true
                stressSwitch.isHidden = true
                illnessSwitch.isHidden = true
            }
            else{
                stressLabel.isHidden = false
                illnessLabel.isHidden = false
                stressSwitch.isHidden = false
                illnessSwitch.isHidden = false
            }
        }
    }

    //MARK: - Override viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        favouritesButton.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        
        daysToShow = "seven"
        showFavouritesHealth = false
        stressSwitch.onTintColor = #colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1)
        illnessSwitch.onTintColor = #colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1)
        stressSwitch.setOn(false, animated: true)
        illnessSwitch.setOn(false, animated: true)
        
        let nc = NotificationCenter.default
        //Observer to update currentDay variable to match graph's day
        nc.addObserver(self, selector: #selector(updateDay(notification:)), name: Notification.Name("dayChanged"), object: nil)
        

    }
    
    //MARK: - Update Day
    ///Updates the currentDay variable with a date provided via notification from ViewControllerGraph
    @objc private func updateDay(notification: Notification) {
        currentDay = notification.object as! Date
    }
    
    //MARK: - Filter actions
    //Filters toggle and set colours to show state
    @IBAction private func sevenDaysButton(_ sender: UIButton) {
        daysToShow  = "seven"
        showFavouritesHealth = false
    }
    
    @IBAction private func thirtyDaysButton(_ sender: UIButton) {
        daysToShow = "thirty"
        showFavouritesHealth = false
    }
    
    @IBAction private func sixtyDaysButton(_ sender: UIButton) {
        daysToShow = "sixty"
        showFavouritesHealth = false
    }

    @IBAction private func filterHypoButton(_ sender: Any) {
        if filterHypo == false{
            filterHypo = true
            filterHypoOutlet.setTitleColor(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), for: .normal)
        }
        else {
            filterHypo = false
            filterHypoOutlet.setTitleColor(#colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1), for: .normal)

        }
    }
    @IBAction private func filterHyperButton(_ sender: Any) {
        if filterHyper == false{
            filterHyper = true
            filterHyperOutlet.setTitleColor(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), for: .normal)
        }
        else {
            filterHyper = false
            filterHyperOutlet.setTitleColor(#colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1), for: .normal)
        }
    }
    @IBAction private func filterExerciseButton(_ sender: Any) {
        if filterExercise == false{
            filterExercise = true
            filterExerciseOutlet.setTitleColor(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), for: .normal)
        }
        else {
            filterExercise = false
            filterExerciseOutlet.setTitleColor(#colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1), for: .normal)
        }
    }
    @IBAction private func filterStressButton(_ sender: Any) {
        if filterStress == false{
            filterStress = true
            filterStressOutlet.setTitleColor(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), for: .normal)
        }
        else {
            filterStress = false
            filterStressOutlet.setTitleColor(#colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1), for: .normal)
        }
    }
    @IBAction private func filterIllnessButton(_ sender: Any) {
        if filterIllness == false{
            filterIllness = true
            filterIllnessOutlet.setTitleColor(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), for: .normal)
        }
        else {
            filterIllness = false
            filterIllnessOutlet.setTitleColor(#colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1), for: .normal)
        }
    }
    
    //MARK: - Stress and Illness actions
    //When turned on, stores start date
    //When turned off, adds start and end to a stress log
    @IBAction private func stressSwitchButton(_ sender: Any) {
        if stressSwitch.isOn{
            stressStart = Date()
        }
        else{
            ModelController().addStress(start: stressStart!, end: Date())
            stressStart = nil
        }
    }

    @IBAction private func illnessSwitchButton(_ sender: Any) {
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
    @IBAction private func toggleFavourites(_ sender: Any) {
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
    
    //TODO: Add a way to remove favourites
    ///Delegate function to toggle whether a day is favourited
    func didPressButton(_ tag: Int) {
        if showFavouritesHealth != true{
            let toFav = loggedDays[tag]
            ModelController().toggleFavouriteDay(item: toFav)
            updateTable()
        }
    }
    
    //MARK: - View Day Button
    ///When pressed in log, sends a notificaiton with that day, which is picked up by graph and set as shown day
    func  didPressViewDayButton(_ tag: Int) {
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("setDay"), object: (loggedDays[tag].date)!)
    }
    
    
    //MARK: - Table functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loggedDays.count
    }
    
    ///Provides setup for table cells, setting each label
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!ViewControllerTableViewCell
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = #colorLiteral(red: 0.9455107252, green: 0.9455107252, blue: 0.9455107252, alpha: 1)
        cell.selectedBackgroundView = backgroundView
        
        cell.cellDelegate = self
        cell.tag = indexPath.row
        
        let currentDay = loggedDays[indexPath.row]
        
        cell.dateInLog.text = currentDay.date
        
        //Sets favourited item star colour
        if ModelController().itemInFavouritesDay(item: currentDay){
            cell.favouriteHealthButton.tintColor = #colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1)
        }
        else{
            cell.favouriteHealthButton.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        }
        //Sets low/avg/high in expanded cell
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
    
    ///Updates the table by re-fetching either a list of filtered days, or the user's favourites
    private func updateTable(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        if showFavouritesHealth == true{
            let loggedDays = ModelController().fetchFavouritesDays()
            self.loggedDays = loggedDays
        }
        else{
            //Filtering to previous 7/30/60 days
            if(daysToShow == "seven"){
                let loggedDays = ModelController().fetchDay()
                self.loggedDays = loggedDays.filter({ (Day) -> Bool in
                    dateFormatter.date(from: Day.date!)! > Calendar.current.date(byAdding: .day, value: -7, to: Date())!
                })
            }
            else if(daysToShow == "thirty"){
                let loggedDays = ModelController().fetchDay()
                self.loggedDays = loggedDays.filter({ (Day) -> Bool in
                    dateFormatter.date(from: Day.date!)! > Calendar.current.date(byAdding: .day, value: -30, to: Date())!              })
            }
            else if(daysToShow == "sixty"){
                let loggedDays = ModelController().fetchDay()
                self.loggedDays = loggedDays.filter({ (Day) -> Bool in
                    dateFormatter.date(from: Day.date!)! > Calendar.current.date(byAdding: .day, value: -60, to: Date())!
                })
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
    
    //Allows expanding of table cell when selected
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
    
    //Allows cell to be expanded by adjusting row height for that cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedCellIndexPath.contains(indexPath) {
            return selectedCellHeight
        }
        return unselectedCellHeight
    }
 
}
