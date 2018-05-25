//
//  CustomView.swift
//  ARISES
//
//  Created by Xiaoyu Ma on 14/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//
import UIKit



class CustomView: UIView {
    
    var dailyHigh: CGFloat
    var dailyLow: CGFloat
    var avgArrayValue: CGFloat
    
    init(frame: CGRect, dailyHigh: CGFloat) {
        self.dailyHigh = 0
        self.avgArrayValue = 0
        self.dailyLow = 0
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.dailyHigh = 0
        self.avgArrayValue = 0
        self.dailyLow = 0
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
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
        //seperation edges (optional)
        
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
        
        //daily low high range
        if(!((self.dailyLow == 0) && (self.dailyHigh == 0) && (self.avgArrayValue == 0))){
            let h = bounds.height
            let h1 = self.dailyHigh * h / 20
            let h2 = self.dailyLow * h / 20
            //draw rangebar
            let barPath = UIBezierPath()
            barPath.move(to: CGPoint(x: bounds.width/2, y: h-h1))
            barPath.addLine(to: CGPoint(x: bounds.width/2, y: h-h2))
            barPath.lineWidth = 4.0
            UIColor.blue.setStroke()
            barPath.stroke()
            //add top dash
            barPath.move(to: CGPoint(x: bounds.width/2 - 5, y: h-h1))
            barPath.addLine(to: CGPoint(x: bounds.width/2 + 5, y: h-h1))
            barPath.stroke()
            //add bottom dash
            barPath.move(to: CGPoint(x: bounds.width/2 - 5, y: h-h2))
            barPath.addLine(to: CGPoint(x: bounds.width/2 + 5, y: h-h2))
            barPath.stroke()
            
            //add avg
            let h_avg = self.avgArrayValue * h / 20
            let circlePath = UIBezierPath()
            circlePath.addArc(withCenter: CGPoint(x: bounds.width/2, y: h - h_avg), radius: 7.0, startAngle: 0.0, endAngle: 2.0 * CGFloat.pi, clockwise: false)
            UIColor.blue.setFill()
            circlePath.fill()
        }else{
            print("No value")
        }
        //circlePath.stroke()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
}
