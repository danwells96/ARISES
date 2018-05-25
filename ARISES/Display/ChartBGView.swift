//
//  ChartBGView.swift
//  ARISES
//
//  Created by Xiaoyu Ma on 17/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//
//this view acts as chart BG color holder, does not contain range bar
import UIKit

class ChartBGView: UIView {
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath(rect: bounds)
        path.addClip()
        // color bands
        let middleRect = CGRect(
            origin: CGPoint(x: 0.0, y: bounds.height/2),
            size: CGSize(width: frame.width, height: frame.height * 0.3)
        )
        #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1).set()
        UIRectFill(middleRect)
        
        let topRect = CGRect(
            origin: bounds.origin,
            size: CGSize(width: frame.width, height: frame.height / 2))
        #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1).set()
        UIRectFill(topRect)
        
    }
    
    
}
