//
//  ViewController.swift
//  ARISES
//
//  Created by Ryan Armiger on 05/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit

class ViewControllerFood: UIViewController {

    @IBOutlet weak var foodTimeField: UITextField!
    
    var foodTimePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createFoodTimePicker()
    }
    
    func createFoodTimePicker(){
        
        let doneButtonBar = UIToolbar()
        doneButtonBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneWithPicker))
        doneButtonBar.setItems([doneButton], animated: false)
        
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

    
   
}


