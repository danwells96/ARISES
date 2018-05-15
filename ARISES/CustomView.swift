//
//  CustomView.swift
//  ARISES
//
//  Created by Xiaoyu Ma on 14/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit

class CustomView: UIView {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: bounds)
        path.addClip()
        //UIColor.yellow.setFill()
        //path.fill()
        let middleRect = CGRect(
            origin: CGPoint(x: 0.0, y: bounds.height/3),//bounds.origin,
            size: CGSize(width: frame.width, height: frame.height / 3)
        )
        #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1).set()
        UIRectFill(middleRect)
        
        let topRect = CGRect(
            origin: bounds.origin,
        size: CGSize(width: frame.width, height: frame.height / 3))
        #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1).set()
        UIRectFill(topRect)
        
        let seperation = UIBezierPath()
        seperation.move(to: bounds.origin)
        seperation.addLine(to: CGPoint(x: 0.0, y: bounds.height))
        seperation.lineWidth = 2.0
        UIColor.black.setStroke()
        seperation.stroke()
        
        seperation.move(to: CGPoint(x: bounds.width, y: 0.0))
        seperation.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        seperation.lineWidth = 2.0
        UIColor.black.setStroke()
        seperation.stroke()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
}
