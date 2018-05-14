//
//  ViewController.swift
//  ARISES
//
//  Created by Ryan Armiger on 05/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit
import SwiftCharts


class ViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var ColourBox: UIButton!
    
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    
    @IBOutlet weak var chartView: ChartBaseView!
    private var chart: LineChart? // arc
    private var didLayout: Bool = false
    
    @IBOutlet weak var sideView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideView.transform = __CGAffineTransformMake(1, 0.8, 0, 1, 0, -6)
        
        // for rotating the chart when in horizontal view
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !self.didLayout{
            self.didLayout = true
            self.initChart()
        }
    }
  
    private func initChart(){
        var chartSettings = ChartSettings()
        chartSettings.leading = 10
        chartSettings.top = 10
        chartSettings.trailing = 10
        chartSettings.bottom = 10
        chartSettings.labelsToAxisSpacingX = 5
        chartSettings.labelsToAxisSpacingY = 5
        chartSettings.axisTitleLabelsToLabelsSpacing = 4
        chartSettings.axisStrokeWidth = 0.2
        chartSettings.spacingBetweenAxesX = 8
        chartSettings.spacingBetweenAxesY = 8
        chartSettings.labelsSpacing = 0
        
            //map moel data to chart points
        let chartPoints: [ChartPoint] = [(1, 1), (2, 3), (3, 4), (4, 5), (5, 7), (6, 6), (7, 8), (8, 10), (10,11), (12, 14)].map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))} //(x:key, y: value)
        let labelSettings = ChartLabelSettings(font: UIFont.systemFont(ofSize: 11))


        let xValues = ChartAxisValuesStaticGenerator.generateXAxisValuesWithChartPoints(chartPoints, minSegmentCount: 7, maxSegmentCount: 7, multiple: 2, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: false)
        let yValues = ChartAxisValuesStaticGenerator.generateYAxisValuesWithChartPoints(chartPoints, minSegmentCount: 10, maxSegmentCount: 20, multiple: 2, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: true)
        
            // create axis models with axis values and axis title
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "x Axis title", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "y Axis title", settings: labelSettings.defaultVertical()))

            // generate axes layers and calculate chart inner frame, based on the axis models
        let chartFrame = self.chartView.frame
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerframe) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)

        
            // layer displays data-line
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor.blue, lineWidth: 4, animDuration: 1, animDelay: 0)
        let pointslineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel])
        
            // create Guideline Layer
        let glLSettings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.gray, linesWidth: 0.9)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: glLSettings)
 
        
            // label each point
        let viewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsViewsLayer, chart: Chart) -> UIView? in
            let viewSize: CGFloat = Env.iPad ? 30 : 20
            let center = chartPointModel.screenLoc
            let label = UILabel(frame: CGRect(x: (center.x - viewSize / 2)+5, y: (center.y - viewSize / 2)+5, width: 30, height: 30))
            label.backgroundColor = UIColor.clear
            label.textAlignment = NSTextAlignment.center
            label.text = "\(chartPointModel.chartPoint.y.description)"
            label.font = UIFont.boldSystemFont(ofSize: 13)
            return label
        }
            // layer displays chartpoints using viewGenerator
        let chartPointsLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, viewGenerator: viewGenerator)
        
        
            // circle points
        let circleViewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let circleView = ChartPointEllipseView(center: chartPointModel.screenLoc, diameter: 15)
            circleView.animDuration = 1.0
            circleView.fillColor = UIColor.red //default: white
            circleView.borderWidth = 1
            circleView.borderColor = UIColor.red
            return circleView
            
        }
        let chartPointsCircleLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, viewGenerator: circleViewGenerator, displayDelay: 0, delayBetweenItems: 0.05, mode: .translate)
        
        
            // create chart instance with frame and layers
        let chart = Chart(
            view: self.chartView!,
            innerFrame: innerframe, //view.frame,
            settings: ChartSettings.init(),
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,    // not showing up
                pointslineLayer,
                chartPointsLayer,
                chartPointsCircleLayer
            ]
        )
        view.addSubview(chart.view)
        self.chart = chart as? LineChart //optional
        
        //chart.view.backgroundColor = UIColor.lightGray
        //view.backgroundColor = UIColor.white
    }

    
    @objc func rotated() {
        for view in self.chartView.subviews {
            view.removeFromSuperview()
        }
        self.initChart()
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


