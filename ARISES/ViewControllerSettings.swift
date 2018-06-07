//
//  ViewControllerSettings.swift
//  ARISES
//
//  Created by Ryan Armiger on 07/06/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit

class ViewControllerSettings: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        // Do any additional setup after loading the view.
    }
    @IBAction func popupClose(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    

}
