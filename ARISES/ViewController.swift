//
//  ViewController.swift
//  ARISES
//
//  Created by Ryan Armiger on 05/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var ColourBox: UIButton!
    
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    
    @IBOutlet weak var topContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: Actions
    @IBAction func ColourButton1(_ sender: UIButton) {
        if ColourBox.backgroundColor == #colorLiteral(red: 0.9882352941, green: 0.1411764706, blue: 0.8823529412, alpha: 1) {
            ColourBox.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            ColourBox.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.1411764706, blue: 0.8823529412, alpha: 1)
        }
        
    }
    @IBAction func ColourButton2(_ sender: UIButton) {
        if ColourBox.backgroundColor == #colorLiteral(red: 0.05098039216, green: 0.2235294118, blue: 0.9843137255, alpha: 1) {
            ColourBox.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            ColourBox.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.2235294118, blue: 0.9843137255, alpha: 1)
        }
    }
    @IBAction func ColourButton3(_ sender: UIButton) {
        if ColourBox.backgroundColor == #colorLiteral(red: 0.1725490196, green: 0.9921568627, blue: 0.1803921569, alpha: 1) {
            ColourBox.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            ColourBox.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.9921568627, blue: 0.1803921569, alpha: 1)
        }
    }
    @IBAction func ColourButton4(_ sender: UIButton) {
        if ColourBox.backgroundColor == #colorLiteral(red: 0.9921568627, green: 0.5254901961, blue: 0.1411764706, alpha: 1) {
            ColourBox.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            ColourBox.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.5254901961, blue: 0.1411764706, alpha: 1)
        }
    }
    
    
}


