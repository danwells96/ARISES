//
//  ViewControllerMain.swift
//  ARISES
//
//  Created by Ryan Armiger on 16/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import Foundation
import UIKit

enum MainViewState
{
    case uninitialised
    case health
    case food
    case exercise
    case advice
}

class ViewControllerMain: UIViewController{

    
    //TODO: Save and restore open view between app closing
    
    //MARK: - Properties
    // Views with status indicators
    @IBOutlet weak var viewHealth: UIView!
    @IBOutlet weak var viewFood: UIView!
    @IBOutlet weak var viewAdvice: UIView!
    @IBOutlet weak var viewExercise: UIView!
    // Containers for embedding view contents
    @IBOutlet weak var containerHealth: UIView!
    @IBOutlet weak var containerFood: UIView!
    @IBOutlet weak var containerAdvice: UIView!
    @IBOutlet weak var containerExercise: UIView!
    // Indicator outlet for toggling
    @IBOutlet weak var indicatorFood: UIView!
    @IBOutlet weak var indicatorExercise: UIView!
    @IBOutlet weak var indicatorHealth: UIView!
    @IBOutlet weak var indicatorAdvice: UIView!
    
    //Insulin outlets
    @IBOutlet weak var glucoseButtonOutlet: UIButton!
    @IBOutlet weak var insulinTextField: UITextField!
    @IBOutlet weak var glucoseClockOutlet: UIButton!
    @IBOutlet weak var insulinTimeField: UITextField!
    private var insulinTimePicker = UIDatePicker()
    
    
    
        
    
    // Variables for rounding and shadow extension
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 25.0
    private var fillColor: UIColor = .blue // the color applied to the shadowLayer, rather than the view's backgroundColor
    //Variable to track state of views
    private var state: MainViewState = .uninitialised
    {
        didSet
        {
            updateViews()
        }
    }
    
   
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        self.state = .food
        
        glucoseButtonOutlet.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        insulinTextField.isHidden = true
        glucoseClockOutlet.tintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        glucoseClockOutlet.isHidden = true
        insulinTimeField.isHidden = true
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneWithKeypad))
        
        toolBar.setItems([flexible, doneButton], animated: true)
        
        insulinTextField.inputAccessoryView = toolBar

        createInsulinTimePicker()
        
       // let nc = NotificationCenter.default
       // nc.addObserver(self, selector: #selector(updateDay(notification:)), name: Notification.Name("dayChanged"), object: nil)


    }
    /*
    @objc func updateDay(notification: Notification) {
        self.today = notification.object as! Date
    }
 */
    
    //MARK: - View re-positioning
    //Func to set state cases
    private func updateViews()
    {
        switch self.state
        {
        case .food:
            //containerFood.alpha = 0.0
            view.bringSubview(toFront: viewFood)
            /*UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.containerFood.alpha = 1.0
            }, completion: nil)*/
            containerFood.isHidden = false
            containerAdvice.isHidden = true
            containerHealth.isHidden = true
            containerExercise.isHidden = true
            indicatorFood.isHidden = true
            indicatorAdvice.isHidden = false
            indicatorHealth.isHidden = false
            indicatorExercise.isHidden = false

        case .exercise:
            self.view.bringSubview(toFront: self.viewExercise)
            /*UIView.animate(withDuration: 0.001, animations: {
                self.viewExercise.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                
            }) { (finished) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.viewExercise.transform = CGAffineTransform.identity
                })
            }*/
            /*containerExercise.alpha = 0.0
            view.bringSubview(toFront: viewExercise)
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                self.containerExercise.alpha = 1.0
            }, completion: nil)*/
            containerFood.isHidden = true
            containerAdvice.isHidden = true
            containerHealth.isHidden = true
            containerExercise.isHidden = false
            indicatorFood.isHidden = false
            indicatorAdvice.isHidden = false
            indicatorHealth.isHidden = false
            indicatorExercise.isHidden = true
            
        case .health:
           self.view.bringSubview(toFront: self.viewHealth)
           /*UIView.animate(withDuration: 0.001, animations: {
                self.viewHealth.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
            }) { (finished) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.viewHealth.transform = CGAffineTransform.identity
                })
            }*/
            //containerHealth.alpha = 0
           //UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            //    self.containerHealth.alpha = 1.0
            //}, completion: nil)
            containerFood.isHidden = true
            containerAdvice.isHidden = true
            containerHealth.isHidden = false
            containerExercise.isHidden = true
            indicatorFood.isHidden = false
            indicatorAdvice.isHidden = false
            indicatorHealth.isHidden = true
            indicatorExercise.isHidden = false
        case .advice:
            //containerAdvice.alpha = 0.0
            view.bringSubview(toFront: viewAdvice)
            /*UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.containerAdvice.alpha = 1.0
            }, completion: nil)*/
            containerFood.isHidden = true
            containerAdvice.isHidden = false
            containerHealth.isHidden = true
            containerExercise.isHidden = true
            indicatorFood.isHidden = false
            indicatorAdvice.isHidden = true
            indicatorHealth.isHidden = false
            indicatorExercise.isHidden = false
        case .uninitialised:
            print("uninitialised view state")
        }
    }

    @IBAction func healthButton(_ sender: UIButton) {
        //Would provide a delay after clicking (in seconds)
        //DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        self.state = .health
        //}
    }
    
    @IBAction func foodButton(_ sender: UIButton) {
        self.state = .food
    }
    
    @IBAction func exerciseButton(_ sender: UIButton) {
        self.state = .exercise
    }
    
    @IBAction func adviceButton(_ sender: UIButton) {
        self.state = .advice
    }
    
    //MARK: - Insulin actions
    @IBAction func glucoseClockButton(_ sender: Any) {
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
    
    @IBAction func glucoseButton(_ sender: Any) {
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
        
        
    //Food Time picker
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
    
    //MARK: - Settings popup
    
    @IBAction func settingsPopup(_ sender: Any) {
        UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!)
//        let popupViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "settings") as! ViewControllerSettings
//        self.addChildViewController(popupViewController)
//        popupViewController.view.frame = self.view.frame
//        self.view.addSubview(popupViewController.view)
//        popupViewController.didMove(toParentViewController: self)
    }
    
}
//MARK: - Extensions
//MARK: Rounding and shadow extensions
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
/*
extension UILabel {
    @IBInspectable
    var image: UIImage? {
        get {
            return self.image
        }
        set {
            self.image = newValue
        }
    }
 }
 */
    

