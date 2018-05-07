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
    @IBOutlet weak var viewExpandedFood: UIView!
    @IBOutlet weak var viewExpandedHealth: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Actions
    @IBAction func ExpandFood(_ sender: UIButton) {
        viewExpandedFood.isHidden = false
    }
    @IBAction func ContractFood(_ sender: UIButton) {
        viewExpandedFood.isHidden = true
    }
    @IBAction func ExpandHealth(_ sender: UIButton) {
        viewExpandedHealth.isHidden = false
    }
    @IBAction func ContractHealth(_ sender: UIButton) {
        viewExpandedHealth.isHidden = true
    }
    
}
