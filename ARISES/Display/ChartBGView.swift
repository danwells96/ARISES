//
//  ChartBGView.swift
//  ARISES
//
//  Created by Xiaoyu Ma on 17/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//
//this view acts as chart BG color holder, does not contain range bar
import UIKit

/**
*   This class is a subclass of UIView used to create the three bands of the 'safe' range for the background of the chart using it's 
*   methods.
*/
class ChartBGView: UIView {
    
	//MARK: Methods
	/**
		The draw method is called on the instantiation of the ChartBGView. It calls methods to create the 3 bands that show the 'safe'
		range of blood glucose measurements.
		- Paramater rect: CGRect, the bounds of the View.
	*/
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: bounds)
        path.addClip()
        
        drawMiddleBand()
        
        drawTopBand()
        
    }
	
    ///Creates a rectangle of colour White from the mid-point of the CustomView (~10 on graph to ~4) to create the 'safe' region.
    private func drawMiddleBand(){
        let middleRect = CGRect(
            origin: CGPoint(x: 0.0, y: bounds.height/2),
            size: CGSize(width: frame.width, height: frame.height * 0.3)
        )
        #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1).set()
        UIRectFill(middleRect)
    }
    
    ///Creates a rectangle with a size of the top half of the CustomView giving the top band (between 10 and 20 on the graph).
    private func drawTopBand(){
        let topRect = CGRect(
            origin: bounds.origin,
            size: CGSize(width: frame.width, height: frame.height / 2))
        #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1).set()
        UIRectFill(topRect)
    }
    
    
}
