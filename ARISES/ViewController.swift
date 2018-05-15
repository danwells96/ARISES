//
//  ViewController.swift
//  ARISES
//
//  Created by Ryan Armiger on 05/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit
import Foundation
import SwiftCharts


class ViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var ColourBox: UIButton!
    
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    
    @IBOutlet weak var chartView: ChartBaseView!
       
    private var chart: Chart?
    private var didLayout: Bool = false
    
    
    
    @IBOutlet weak var sideView2: CustomView!
    @IBOutlet weak var sideView: CustomView!
    
    @IBOutlet weak var rightView: CustomView!
    //        {
//        didSet{
//            let swipe = UISwipeGestureRecognizer(target: self, action: Selector, "nextCard")
//            swipe.direction = [.left, .right]
//            sideView.addGestureRecognizer(swipe)
//
//        }
//    }
//    @objc func nextCard(){
//    }
//

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideView.transform = __CGAffineTransformMake(1, 0.8, 0, 1, 0, 2)

        self.sideView2.transform = __CGAffineTransformMake(1, 0.8, 0, 1, 0, 0)

        self.rightView.transform = __CGAffineTransformMake(1, -0.8, 0, 1, 0, 0)

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
   
    func csv(data: String) -> [[String]]{
    
        var result: [[String]] = []
        let rows = data.components(separatedBy: ("\n"))
        for row in rows{
            let columns = row.components(separatedBy: "\t")
            result.append(columns)
        }
        return result
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
        
        /*let file: FileHandle? = FileHandle(forReadingAtPath: "CustomView.swift")
        if file != nil{
            let data = file?.readDataToEndOfFile()
            file?.closeFile()
            let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print(str!)
        }else{
            print("sth went wrong")
        }*/
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent("log_final_l") {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                print("FILE AVAILABLE")
            } else {
                print("FILE NOT AVAILABLE")
            }
        } else {
            print("FILE PATH NOT AVAILABLE")
        }
        
            //map moel data to chart points
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd HH:mm"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let startDate: Date? = dateFormatter.date(from: "2018-05-15 00:00")
        var currTime: Date? = startDate
        
        //let chartPoints: [ChartPoint] = [(1, 1), (2, 3), (3, 4), (4, 5), (5, 7), (6, 6), (7, 8), (8, 10), (10,11), (12, 14)].map{ChartPoint(x: ChartAxisValueDate($0.0), y: ChartAxisValueInt($0.1))}
        var dateArray = [ChartAxisValueDate]()
        var valueArray = [ChartAxisValueInt]()
        var points = [ChartPoint]()
        for i in 0...288{
            let data = i%20
            dateArray.append(ChartAxisValueDate(date: currTime!, formatter: dateFormatter))
            valueArray.append(ChartAxisValueInt(data))
            points.append(ChartPoint(x: dateArray[dateArray.endIndex-1], y: valueArray[valueArray.endIndex-1]))
            currTime!.addTimeInterval(300)
            
            //SOmething needs changing to initialise chart point
        }
        
        let chartPoints = points
        let yLabelSettings = ChartLabelSettings(font: UIFont.systemFont(ofSize: 11))
        let xLabelSettings = ChartLabelSettings(font: UIFont.systemFont(ofSize: 8), fontColor: UIColor.black, rotation: 90, rotationKeep: .top)

        //let xValues = ChartAxisValuesStaticGenerator.generateXAxisValuesWithChartPoints(chartPoints, minSegmentCount: 7, maxSegmentCount: 7, multiple: 2, axisValueGenerator: {ChartAxisValueDate($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: false)
        let xValues = ChartAxisValuesGeneratorDate(unit: .hour, preferredDividers: 12, minSpace: 0.5, maxTextSize: 12)
        let yValues = ChartAxisValuesStaticGenerator.generateYAxisValuesWithChartPoints(chartPoints, minSegmentCount: 10, maxSegmentCount: 20, multiple: 2, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: yLabelSettings)}, addPaddingSegmentIfEdge: true)
        
            // create axis models with axis values and axis title
        let startTime: Date? = dateFormatter.date(from: "2018-05-15 00:00")
        let endTime: Date? = dateFormatter.date(from: "2018-05-16 00:00")
        let xLabelGenerator = ChartAxisLabelsGeneratorDate(labelSettings: xLabelSettings, formatter: timeFormatter)
        
        let xModel = ChartAxisModel(firstModelValue: (startTime!.timeIntervalSince1970), lastModelValue: (endTime!.timeIntervalSince1970), axisTitleLabel: ChartAxisLabel(text: "Time", settings: yLabelSettings), axisValuesGenerator: xValues, labelsGenerator: xLabelGenerator)
        //let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "x Axis title", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Glucose", settings: yLabelSettings.defaultVertical()))

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
            label.font = UIFont.boldSystemFont(ofSize: 0)
            return label
        }
            // layer displays chartpoints using viewGenerator
        let chartPointsLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, viewGenerator: viewGenerator)
    
        
            // circle points
        let circleViewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let circleView = ChartPointEllipseView(center: chartPointModel.screenLoc, diameter: 5)
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
        self.chart = chart //as? LineChart //optional
        //chart.view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }

    
    @objc func rotated() {
        for view in self.chartView.subviews {
            view.removeFromSuperview()
        }
        self.initChart()
    }
    
    
    //MARK: Actions
    @IBAction func ColourButton1(_ sender: UIButton) {
        if ColourBox.backgroundColor == #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1) {
            ColourBox.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            ColourBox.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
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


