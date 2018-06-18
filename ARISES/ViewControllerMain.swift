//
//  ViewControllerMain.swift
//  ARISES
//
//  Created by Ryan Armiger on 16/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit

///State enum for domain tabs
enum MainViewState
{
    case uninitialised
    case health
    case food
    case exercise
    case advice
}

class ViewControllerMain: UIViewController{
    
    //MARK: - Outlets
    // Views with status indicators
    @IBOutlet weak private var viewHealth: UIView!
    @IBOutlet weak private var viewFood: UIView!
    @IBOutlet weak private var viewAdvice: UIView!
    @IBOutlet weak private var viewExercise: UIView!
    // Containers for embedding view contents
    @IBOutlet weak private var containerHealth: UIView!
    @IBOutlet weak private var containerFood: UIView!
    @IBOutlet weak private var containerAdvice: UIView!
    @IBOutlet weak private var containerExercise: UIView!
    // Indicator outlet for toggling
    @IBOutlet weak private var indicatorFood: UIView!
    @IBOutlet weak private var indicatorExercise: UIView!
    @IBOutlet weak private var indicatorHealth: UIView!
    @IBOutlet weak private var indicatorAdvice: UIView!
    
    //Labels
    @IBOutlet weak private var foodLabel: UILabel!
    @IBOutlet weak private var exerciseLabel: UILabel!
    @IBOutlet weak private var adviceLabel: UILabel!
    @IBOutlet weak private var healthLabel: UILabel!
    
    
    //Insulin outlets
    @IBOutlet weak private var glucoseButtonOutlet: UIButton!
    @IBOutlet weak private var insulinTextField: UITextField!
    @IBOutlet weak private var glucoseClockOutlet: UIButton!
    @IBOutlet weak private var insulinTimeField: UITextField!
    
    //MARK: - Properties
    ///Tracks date set by graph and hides insulin entry fields when not on current day
    private var currentDay = Date(){
        didSet{
            if currentDay != Calendar.current.startOfDay(for: Date()) {
                glucoseButtonOutlet.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
                glucoseButtonOutlet.isHidden = true
                insulinTextField.isHidden = true
                glucoseClockOutlet.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
                glucoseClockOutlet.isHidden = true
                insulinTimeField.isHidden = true
            }
            else{
                glucoseButtonOutlet.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
                glucoseButtonOutlet.isHidden = false
                insulinTextField.isHidden = true
                glucoseClockOutlet.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
                glucoseClockOutlet.isHidden = true
                insulinTimeField.isHidden = true
            }
        }
    }
    private var insulinTimePicker = UIDatePicker()
    ///Stores whether keyboard is open, to smooth transitions between tabs
    private var keyboardOpen = false
    
    // Variables for rounding and shadow extension
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 25.0
    private var fillColor: UIColor = .blue
    ///Variable to track state of views
    private var state: MainViewState = .uninitialised
    {
        didSet
        {
            updateViews()
        }
    }
    
    
    //MARK: - Override viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.state = .food
        
        glucoseButtonOutlet.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        glucoseButtonOutlet.isHidden = false
        insulinTextField.isHidden = true
        glucoseClockOutlet.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        glucoseClockOutlet.isHidden = true
        insulinTimeField.isHidden = true
        
        //Data entry 'done' toolbars
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneWithKeypad))
        
        toolBar.setItems([flexible, doneButton], animated: true)
        
        insulinTextField.inputAccessoryView = toolBar
        
        //Instantiates picker for insulin time entry
        createInsulinTimePicker()
        
        let nc = NotificationCenter.default
        //Observer to update currentDay variable to match graph's day
        nc.addObserver(self, selector: #selector(updateDay(notification:)), name: Notification.Name("dayChanged"), object: nil)
        

        //Observers to determine keyboard state
        nc.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        nc.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    //MARK: - Update Day
    ///Updates the currentDay variable with a date provided via notification from ViewControllerGraph
    @objc private func updateDay(notification: Notification) {
        currentDay = notification.object as! Date
    }
    
    //MARK: - Functions for tracking when keyboard open
    @objc private func keyboardWillShow(sender: NSNotification) {
        keyboardOpen = true
    }
    @objc private func keyboardWillHide(sender: NSNotification) {
        keyboardOpen = false
    }
    
    //MARK: - View re-positioning
    //Func to set state cases
    private func updateViews()
    {
        switch self.state
        {
        case .food:
            view.bringSubview(toFront: viewFood)
            containerFood.isHidden = false
            containerAdvice.isHidden = true
            containerHealth.isHidden = true
            containerExercise.isHidden = true
            indicatorFood.isHidden = true
            indicatorAdvice.isHidden = false
            indicatorHealth.isHidden = false
            indicatorExercise.isHidden = false
            
            foodLabel.isHidden = true
            healthLabel.isHidden = false
            exerciseLabel.isHidden = false
            adviceLabel.isHidden = false
            
        case .exercise:
            self.view.bringSubview(toFront: self.viewExercise)
            containerFood.isHidden = true
            containerAdvice.isHidden = true
            containerHealth.isHidden = true
            containerExercise.isHidden = false
            indicatorFood.isHidden = false
            indicatorAdvice.isHidden = false
            indicatorHealth.isHidden = false
            indicatorExercise.isHidden = true
            
            foodLabel.isHidden = false
            healthLabel.isHidden = false
            exerciseLabel.isHidden = true
            adviceLabel.isHidden = false
            
        case .health:
            self.view.bringSubview(toFront: self.viewHealth)
            containerFood.isHidden = true
            containerAdvice.isHidden = true
            containerHealth.isHidden = false
            containerExercise.isHidden = true
            indicatorFood.isHidden = false
            indicatorAdvice.isHidden = false
            indicatorHealth.isHidden = true
            indicatorExercise.isHidden = false
            
            foodLabel.isHidden = false
            healthLabel.isHidden = true
            exerciseLabel.isHidden = false
            adviceLabel.isHidden = false
            
        case .advice:
            view.bringSubview(toFront: viewAdvice)
            containerFood.isHidden = true
            containerAdvice.isHidden = false
            containerHealth.isHidden = true
            containerExercise.isHidden = true
            indicatorFood.isHidden = false
            indicatorAdvice.isHidden = true
            indicatorHealth.isHidden = false
            indicatorExercise.isHidden = false
            
            foodLabel.isHidden = false
            healthLabel.isHidden = false
            exerciseLabel.isHidden = false
            adviceLabel.isHidden = true
            
        case .uninitialised:
            print("uninitialised view state")
        }
    }
    
    //MARK: - Buttons to open each domain
    @IBAction private func healthButton(_ sender: UIButton) {
        self.state = .health
    }
    
    @IBAction private func foodButton(_ sender: UIButton) {
        //If keyboard is open and tab is swapped, dismiss it and then change state smoothly
        if keyboardOpen == true{
            view.endEditing(true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.state = .food
            }
        }
        else{
            self.state = .food
        }
    }
    
    @IBAction private func exerciseButton(_ sender: UIButton) {
        if keyboardOpen == true{
            view.endEditing(true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.state = .exercise
            }
        }
        else{
            self.state = .exercise
        }
    }
    
    @IBAction private func adviceButton(_ sender: UIButton) {
        self.state = .advice
    }
    
    
    //MARK: - Insulin actions
    @IBAction private func glucoseClockButton(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            if self.glucoseClockOutlet.tintColor == #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1) {
                self.glucoseClockOutlet.tintColor = #colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1)
                self.insulinTimeField.isHidden = false
            }
            else{
                self.glucoseClockOutlet.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
                self.insulinTimeField.isHidden = true
            }
        }
    }
    
    @IBAction private func glucoseButton(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            if self.glucoseButtonOutlet.tintColor == #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1) {
                self.glucoseButtonOutlet.tintColor = #colorLiteral(red: 0.3921568627, green: 0.737254902, blue: 0.4392156863, alpha: 1)
                self.insulinTextField.isHidden = false
                self.glucoseClockOutlet.isHidden = false
                
            }
            else{
                self.glucoseButtonOutlet.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
                self.insulinTextField.isHidden = true
                self.glucoseClockOutlet.isHidden = true
                self.glucoseClockOutlet.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
                self.insulinTimeField.isHidden = true
                
                //add insulin if not nil
                if (self.insulinTextField.text != ""){
                    if self.insulinTimeField.text != ""{
                        ModelController().addInslin(units: Double((self.insulinTextField.text)!)!, time: self.insulinTimeField.text!, date: Date())
                        self.insulinTextField.text = ""
                    }
                    else{
                        let currentTime = ModelController().formatDateToHHmm(date: Date())
                        ModelController().addInslin(units: Double((self.insulinTextField.text)!)!, time: currentTime, date: Date())
                        
                        self.insulinTextField.text = ""
                        self.insulinTimeField.text = ""
                    }
                }
            }
        }
    }
    
    
    //Insulin Time picker
    private func createInsulinTimePicker(){
        
        let doneButtonBar = UIToolbar()
        doneButtonBar.sizeToFit()
        
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: #selector(doneWithPicker))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneWithPicker))
        
        doneButtonBar.setItems([flexible, doneButton], animated: true)
        
        insulinTimeField.inputAccessoryView = doneButtonBar
        insulinTimeField.inputView = insulinTimePicker
        
        insulinTimePicker.datePickerMode = .time
    }
    @objc private func doneWithPicker(){
        
        insulinTimeField.text = ModelController().formatDateToHHmm(date: insulinTimePicker.date)
        self.view.endEditing(true)
    }
    
    @objc private func doneWithKeypad(){
        view.endEditing(true)
    }
    
    //MARK: - Settings
    //Opens phone settings
    @IBAction func settingsPopup(_ sender: Any) {
        UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!)
    }
    
}

//MARK: - Extensions
//Rounding view and shadow extension
extension UIView {
    func setRadius(radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 8
        self.layer.masksToBounds = true
        
    }
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}


