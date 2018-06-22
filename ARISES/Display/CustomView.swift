//
//  CustomView.swift
//  ARISES
//
//  Created by Xiaoyu Ma on 14/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//
//  This view draws glucose range bar on a day

import UIKit

/**
*   The class is a subclass of UIView and is used in the bifocal display as the sideViews. It includes methods to draw the daily glucose
*   ranges calculated using the member data and to draw the upper band for the background 'safe' range.
*/
class CustomView: UIView {
    
	//MARK: Member Variables
	///CGFloat containing the maximum glucose measurement for that day.
    var dailyHigh: CGFloat
	///CGFloat containing the minimum glucose measurement for that day.
    var dailyLow: CGFloat
	///CGFloat containing the mean average of the glucose measurements for that day.
    var avgArrayValue: CGFloat
    
	//MARK: Member Methods
	/**
		The init method is called on the instantiation of a CustomView. It initializes the member variables to 0 which is used to determine
		if there is any data stored for this CustomView.
		- Paramater frame: CGRect, the bounds of the View.
		- Paramater dailyHigh: CGFloat, the maximum glucose reading for the day.
	*/
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
    
	/**
		This is an override method from the superclass and is called when the CustomView is created by the ViewController. It calls
		methods which draw the 'safe' region onto the view. It also sets the visibility of the CustomView depending on if the CustomView
		has data stored in it.
		- Paramater rect: CGRect, the bounds of the CustomView.
	*/
    override func draw(_ rect: CGRect) {

        let path = UIBezierPath(rect: bounds)
        path.addClip()
        
        colourTopBand()
        
        colourMiddleBand()
        
		//If no data is stored (i.e the view is still initialized), makes the view invisible.
        if(!((self.dailyLow == 0) && (self.dailyHigh == 0) && (self.avgArrayValue == 0))){           
            self.isHidden = false
            drawRangeBar()
        }else{
            self.isHidden = true
        }
    }
    
    ///Creates a rectangle of colour White from the mid-point of the CustomView (~10 on graph to ~4) to create the 'safe' region.
    private func colourMiddleBand(){
        
        let middleRect = CGRect(
            origin: CGPoint(x: 0.0, y: bounds.height/2),
            size: CGSize(width: frame.width, height: frame.height * 0.3)
        )
        #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1).set()
        UIRectFill(middleRect)
    }
    
    ///fill bgcolor of 'high/low' bands
    private func colourTopBand(){
        
        let topRect = CGRect(
            origin: bounds.origin,
            size: CGSize(width: frame.width, height: frame.height / 2))
        #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1).set()
        UIRectFill(topRect)
    }
    
    private func drawRangeBar(){
        
        let h = bounds.height
        let h1 = self.dailyHigh * h / 20
        let h2 = self.dailyLow * h / 20
        let barPath = UIBezierPath()
        barPath.move(to: CGPoint(x: bounds.width/2, y: h-h1))
        barPath.addLine(to: CGPoint(x: bounds.width/2, y: h-h2))
        barPath.lineWidth = 4.0
        UIColor.blue.setStroke()
        barPath.stroke()
        // Top dash
        barPath.move(to: CGPoint(x: bounds.width/2 - 5, y: h-h1))
        barPath.addLine(to: CGPoint(x: bounds.width/2 + 5, y: h-h1))
        barPath.stroke()
        // Bottom dash
        barPath.move(to: CGPoint(x: bounds.width/2 - 5, y: h-h2))
        barPath.addLine(to: CGPoint(x: bounds.width/2 + 5, y: h-h2))
        barPath.stroke()
        // Add avg
        let h_avg = self.avgArrayValue * h / 20
        let circlePath = UIBezierPath()
        circlePath.addArc(withCenter: CGPoint(x: bounds.width/2, y: h - h_avg), radius: 7.0, startAngle: 0.0, endAngle: 2.0 * CGFloat.pi, clockwise: false)
        UIColor.blue.setFill()
        circlePath.fill()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
}
