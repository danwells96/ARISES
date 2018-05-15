//
//  ViewControllerHealth.swift
//  ARISES
//
//  Created by Ryan Armiger on 11/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerHealth: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var stressField: UITextField!
    @IBOutlet weak var illnessField: UITextField!
    
    let stressLevel = ["not", "a little", "quite", "very"]
    var stressPicker = UIPickerView()
    
    //stressfield.delegate = self
    
    //MARK: Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stressPicker.delegate = self
        stressPicker.dataSource = self
        stressField.inputView = stressPicker
    }
    
    //MARK: Actions
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
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
    
}
