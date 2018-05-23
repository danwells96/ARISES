//
//  ViewControllerGraph.swift
//  ARISES
//
//  Created by Ryan Armiger on 16/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//


import UIKit
import Foundation
import SwiftCharts

struct customType{
    var time: String
    var value: Double
}


class ViewControllerGraph: UIViewController{
    
    //Today temp variable till real-time data available
    private var today: String = "5/01/2016 00:00"
    var tMinus1Compare : [Double] = []
    var tMinus2Compare : [Double] = []
    var tMinus3Compare : [Double] = []
    var tMinus4Compare : [Double] = []
    var tPlus1Compare : [Double] = []
    var tPlus2Compare : [Double] = []
    var tPlus3Compare : [Double] = []
    
    
    //MARK: Properties
    @IBOutlet weak var chartView: ChartBaseView!
    private var chart: Chart?
    private var dataLoaded: Bool = false
    private var didLayout: Bool = false
    @IBOutlet weak var sideView2: CustomView!
    @IBOutlet weak var sideView: CustomView!
    @IBOutlet weak var sideView3: CustomView!
    @IBOutlet weak var rightView2: CustomView!
    @IBOutlet weak var rightView3: CustomView!
    @IBOutlet weak var sideView4: CustomView!
    
    @IBOutlet weak var sideViewContainer: UIView!
    @IBOutlet weak var rightSideViewContainer: UIView!
    
    @IBOutlet weak var rightView: CustomView!{
        didSet{
            let recognizer = UISwipeGestureRecognizer()
            if recognizer.direction == .left {
                self.rightView.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Second Transforms
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 500.0
        sideViewContainer.layer.transform = CATransform3DRotate(transform, CGFloat(-45 * Double.pi / 180), 0, 1, 0)
        
        rightSideViewContainer.layer.transform = CATransform3DRotate(transform, CGFloat(45 * Double.pi / 180), 0, 1, 0)
        
        
        //self.rightView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(slideInFromLeft(duration:completionDelegate:_:))))
        
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
  /*
    func setAnchorPoint(anchorPoint: CGPoint, forView view: UIView) {
        var newPoint = CGPoint(x: view.bounds.size.width * anchorPoint.x, y: view.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPoint(x: view.bounds.size.width * view.layer.anchorPoint.x, y: view.bounds.size.height * view.layer.anchorPoint.y)
        
        newPoint = newPoint.applying(view.transform)
        oldPoint = oldPoint.applying(view.transform)
        
        var position = view.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        view.layer.position = position
        view.layer.anchorPoint = anchorPoint
    }
    */
    /*
     override func viewDidAppear(_ animated: Bool) {
     CustomView.animate(
     withDuration: 0.4,
     delay: 0.0,
     options: .curveEaseInOut,
     animations: {
     //self.sideView.isHidden = true
     //self.sideView2.isHidden = true
     //self.sideView.frame.origin.x = 100
     //self.sideView2.willMove(toSuperview: self.sideView)
     })
     { (completed) in
     
     }
     }*/
    /*
     @objc func slideInFromLeft(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil, _ recognizer: UISwipeGestureRecognizer){
     
     if recognizer.direction == .left {
     CustomView.animate(
     withDuration: 0.4,
     delay: 0.0,
     options: .curveEaseInOut,
     animations: {
     self.rightView.isHidden = true
     }){ (completed) in
     }
     }
     }
     */
    var rawData: [String] = ["27/11/2015 07:00",
                             "27/11/2015 07:17",
                             "27/11/2015 07:17",
                             "27/11/2015 08:01",
                             "27/11/2015 12:44",
                             "27/11/2015 15:33",
                             "27/11/2015 15:34",
                             "27/11/2015 17:32",
                             "27/11/2015 17:32",
                             "27/11/2015 19:53",
                             "27/11/2015 19:57",
                             "27/11/2015 21:37",
                             "27/11/2015 22:00",
                             "27/11/2015 23:18",
                             "28/11/2015 08:28",
                             "28/11/2015 08:28",
                             "28/11/2015 09:31",
                             "28/11/2015 10:10",
                             "28/11/2015 03:38",
                             "28/11/2015 03:26",
                             "28/11/2015 12:09",
                             "28/11/2015 13:11",
                             "28/11/2015 17:07",
                             "28/11/2015 17:48",
                             "28/11/2015 19:00",
                             "28/11/2015 20:11",
                             "28/11/2015 21:34",
                             "28/11/2015 23:38",
                             "28/11/2015 23:38",
                             "29/11/2015 00:25",
                             "29/11/2015 06:03",
                             "29/11/2015 10:03",
                             "29/11/2015 10:39",
                             "29/11/2015 13:01",
                             "29/11/2015 14:08",
                             "29/11/2015 19:08",
                             "29/11/2015 23:17",
                             "30/11/2015 07:46",
                             "30/11/2015 18:27",
                             "30/11/2015 23:16",
                             "30/11/2015 23:16",
                             "30/11/2015 23:58",
                             "03/01/2016 01:24",
                             "03/01/2016 10:16",
                             "03/01/2016 10:20",
                             "03/01/2016 11:25",
                             "03/01/2016 14:43",
                             "03/01/2016 15:48",
                             "03/01/2016 18:23",
                             "03/01/2016 20:25",
                             "03/01/2016 21:27",
                             "03/01/2016 22:47",
                             "04/01/2016 07:55",
                             "04/01/2016 13:11",
                             "04/01/2016 14:25",
                             "04/01/2016 16:17",
                             "04/01/2016 18:34",
                             "04/01/2016 20:24",
                             "04/01/2016 21:19",
                             "04/01/2016 23:32",
                             "05/01/2016 07:49",
                             "05/01/2016 12:06",
                             "05/01/2016 12:46",
                             "05/01/2016 14:49",
                             "05/01/2016 15:25",
                             "05/01/2016 16:58",
                             "05/01/2016 18:09",
                             "05/01/2016 20:06",
                             "05/01/2016 22:38",
                             "05/01/2016 23:16",
                             "05/01/2016 23:56",
                             "06/01/2016 07:17",
                             "06/01/2016 11:08",
                             "06/01/2016 13:25",
                             "06/01/2016 16:26",
                             "06/01/2016 18:26",
                             "06/01/2016 19:50",
                             "06/01/2016 22:43",
                             "06/01/2016 23:37"]
    
    var rawValues: [Double] = [0,
                               15.4,
                               0,
                               13,
                               8.2,
                               3.2,
                               0,
                               16.2,
                               0,
                               12.7,
                               0,
                               15.6,
                               13.9,
                               0,
                               13.2,
                               0,
                               0,
                               7.1,
                               3.1,
                               3.1,
                               3.1,
                               4.9,
                               6.6,
                               6,
                               3.6,
                               3.6,
                               0,
                               0,
                               14.7,
                               0,
                               0,
                               0,
                               7.8,
                               10.4,
                               11.5,
                               8,
                               0,
                               11.4,
                               6.5,
                               14.4,
                               0,
                               0,
                               9.3,
                               0,
                               10,
                               12.7,
                               6.3,
                               6.2,
                               5.4,
                               4.1,
                               5.1,
                               9.4,
                               8.3,
                               5.3,
                               11.3,
                               12.3,
                               5.1,
                               5.9,
                               16,
                               0,
                               7.4,
                               4.3,
                               4.2,
                               2.4,
                               2.6,
                               9,
                               19.3,
                               3.6,
                               4.1,
                               4.4,
                               9.3,
                               17.2,
                               8.1,
                               9.1,
                               4.1,
                               8.1,
                               4.5,
                               6.6,
                               10.3]
    
    var dataDict: [String: [customType]] = [:]
    
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd/MM/yyyy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "HH"
        
        if(!dataLoaded){
            for time in rawData{
                let day = dateFormatter.date(from: time)
                
                let calender = dayFormatter.string(from: day!)
                
                var tempArray: [customType] = dataDict[calender] ?? [customType]()
                let index = rawData.index(of: time)
                let data = customType(time: timeFormatter.string(from: day!), value: rawValues[index!])
                tempArray.append(data)
                dataDict[calender] = tempArray
            }
            dataLoaded = true
        }
        
        //set function to today() when live code
        let day = dateFormatter.date(from: today)
        
        var dateArray = [ChartAxisValueDate]()
        var valueArray = [ChartAxisValueDouble]()
        var points = [ChartPoint]()
        
        dateArray.removeAll()
        valueArray.removeAll()
        points.removeAll()
        
        
        let keyDay = dayFormatter.string(from: day!)
        let tMinus1 = Calendar.current.date(byAdding: .day, value: -1, to: day!)
        let tMinus2 = Calendar.current.date(byAdding: .day, value: -2, to: day!)
        let tMinus3 = Calendar.current.date(byAdding: .day, value: -3, to: day!)
        let tMinus4 = Calendar.current.date(byAdding: .day, value: -4, to: day!)
        let tPlus1 = Calendar.current.date(byAdding: .day, value: 1, to: day!)
        let tPlus2 = Calendar.current.date(byAdding: .day, value: 2, to: day!)
        let tPlus3 = Calendar.current.date(byAdding: .day, value: 3, to: day!)
        let tMinus1String = dayFormatter.string(from: tMinus1!)
        let tMinus2String = dayFormatter.string(from: tMinus2!)
        let tMinus3String = dayFormatter.string(from: tMinus3!)
        let tMinus4String = dayFormatter.string(from: tMinus4!)
        let tPlus1String = dayFormatter.string(from: tPlus1!)
        let tPlus2String = dayFormatter.string(from: tPlus2!)
        let tPlus3String = dayFormatter.string(from: tPlus3!)

        
        for (key, value) in dataDict{
            //Consider changing if/else ladder into case/switch statement to improve performance (most likely negligable but might make difference with large number of days of data
            
            if(key == keyDay){
                for val in value{
                    if(val.value != 0){
                        let combinedDate = key+" "+val.time
                        valueArray.append(ChartAxisValueDouble(val.value))
                        dateArray.append(ChartAxisValueDate(date: dateFormatter.date(from: combinedDate)!, formatter: dateFormatter))
                        points.append(ChartPoint(x: dateArray[dateArray.endIndex-1], y: valueArray[valueArray.endIndex-1]))
                    }
                }
            }else if(key == tMinus1String){
                for val in value{
                    if(val.value != 0){
                        tMinus1Compare.append(val.value)
                    }
                }
            }else if(key == tMinus2String){
                for val in value{
                    if(val.value != 0){
                        tMinus2Compare.append(val.value)
                    }
                }
            }else if(key == tMinus3String){
                for val in value{
                    if(val.value != 0){
                        tMinus3Compare.append(val.value)
                    }
                }
            }else if(key == tMinus4String){
                for val in value{
                    if(val.value != 0){
                        tMinus4Compare.append(val.value)
                    }
                }
            }else if(key == tPlus1String){
                for val in value{
                    if(val.value != 0){
                        tPlus1Compare.append(val.value)
                    }
                }
            }else if(key == tPlus2String){
                for val in value{
                    if(val.value != 0){
                        tPlus2Compare.append(val.value)
                    }
                }
            }else if(key == tPlus3String){
                for val in value{
                    if(val.value != 0){
                        tPlus3Compare.append(val.value)
                    }
                }
            }
        }
        
        
        if(tMinus1Compare.count > 0){
            sideView.dailyHigh = CGFloat(tMinus1Compare.max()!)
            sideView.avgArrayValue = CGFloat(tMinus1Compare.reduce(0, +) / Double(tMinus1Compare.count))
            sideView.dailyLow = CGFloat(tMinus1Compare.min()!)
        }else{
            sideView.dailyHigh = 0
            sideView.avgArrayValue = 0
            sideView.dailyLow = 0
        }
        
        if(tMinus2Compare.count > 0){
            sideView2.dailyHigh = CGFloat(tMinus2Compare.max()!)
            sideView2.avgArrayValue = CGFloat(tMinus2Compare.reduce(0, +) / Double(tMinus2Compare.count))
            sideView2.dailyLow = CGFloat(tMinus2Compare.min()!)
        }else{
            sideView2.dailyHigh = 0
            sideView2.avgArrayValue = 0
            sideView2.dailyLow = 0
        }
        
        if(tMinus3Compare.count > 0){
            sideView3.dailyHigh = CGFloat(tMinus3Compare.max()!)
            sideView3.avgArrayValue = CGFloat(tMinus3Compare.reduce(0, +) / Double(tMinus3Compare.count))
            sideView3.dailyLow = CGFloat(tMinus3Compare.min()!)
        }else{
            sideView3.dailyHigh = 0
            sideView3.avgArrayValue = 0
            sideView3.dailyLow = 0
        }
        
        if(tMinus4Compare.count > 0){
            sideView4.dailyHigh = CGFloat(tMinus4Compare.max()!)
            sideView4.avgArrayValue = CGFloat(tMinus4Compare.reduce(0, +) / Double(tMinus4Compare.count))
            sideView4.dailyLow = CGFloat(tMinus4Compare.min()!)
        }
        
        if(tPlus1Compare.count > 0){
            rightView.dailyHigh = CGFloat(tPlus1Compare.max()!)
            rightView.avgArrayValue = CGFloat(tPlus1Compare.reduce(0, +) / Double(tPlus1Compare.count))
            rightView.dailyLow = CGFloat(tPlus1Compare.min()!)
        }else{
            rightView.dailyHigh = 0
            rightView.avgArrayValue = 0
            rightView.dailyLow = 0
        }
        
        if(tPlus2Compare.count > 0){
            rightView2.dailyHigh = CGFloat(tPlus2Compare.max()!)
            rightView2.avgArrayValue = CGFloat(tPlus2Compare.reduce(0, +) / Double(tPlus2Compare.count))
            rightView2.dailyLow = CGFloat(tPlus2Compare.min()!)
        }else{
            rightView2.dailyHigh = 0
            rightView2.avgArrayValue = 0
            rightView2.dailyLow = 0
        }
        
        if(tPlus3Compare.count > 0){
            rightView3.dailyHigh = CGFloat(tPlus3Compare.max()!)
            rightView3.avgArrayValue = CGFloat(tPlus3Compare.reduce(0, +) / Double(tPlus3Compare.count))
            rightView3.dailyLow = CGFloat(tPlus3Compare.min()!)
        }else{
            rightView3.dailyHigh = 0
            rightView3.avgArrayValue = 0
            rightView3.dailyLow = 0
        }
        
        //SOmething needs changing to initialise chart point
        
        let chartPoints = points
        let yLabelSettings = ChartLabelSettings(font: UIFont.systemFont(ofSize: 11))
        let xLabelSettings = ChartLabelSettings(font: UIFont.systemFont(ofSize: 8), fontColor: UIColor.black, rotation: 90, rotationKeep: .top)
        
        
        let xValues = ChartAxisValuesGeneratorDate(unit: .hour, preferredDividers: 8, minSpace: 0.5, maxTextSize: 12)
        
        // let yValues = ChartAxisValuesStaticGenerator.generateYAxisValuesWithChartPoints(chartPoints, minSegmentCount: 10, maxSegmentCount: 20, multiple: 2, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: yLabelSettings)}, addPaddingSegmentIfEdge: false)
        
        
        // create axis models with axis values and axis title
        let startTime: Date? = dateFormatter.date(from: today)
        let endTime: Date? = Calendar.current.date(byAdding: .day, value: 1, to: startTime!)
        
        
        //Bob's suggestion of x-axis labels
        
        //  let axisValues = [ChartAxisValueString("Midnight", order: 1, labelSettings: xLabelSettings), ChartAxisValueString("06", order: 2, labelSettings: xLabelSettings), ChartAxisValueString("Noon", order: 3, labelSettings: xLabelSettings), ChartAxisValueString("18", order: 4, labelSettings: xLabelSettings), ChartAxisValueString("", order: 5, labelSettings: xLabelSettings)]
        //  let xModel = ChartAxisModel(axisValues: axisValues, axisTitleLabel: ChartAxisLabel(text: today, settings: yLabelSettings))
        
        let xLabelGenerator = ChartAxisLabelsGeneratorDate(labelSettings: xLabelSettings, formatter: hourFormatter)
        let yLabelGenerator = ChartAxisLabelsGeneratorNumber(labelSettings: yLabelSettings)
        let generator = ChartAxisGeneratorMultiplier(4)
        
        
        let xModel = ChartAxisModel(firstModelValue: (startTime!.timeIntervalSince1970), lastModelValue: (endTime!.timeIntervalSince1970), axisTitleLabel: ChartAxisLabel(text: dayFormatter.string(from: startTime!), settings: yLabelSettings), axisValuesGenerator: xValues, labelsGenerator: xLabelGenerator)
        
        //     let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Glucose (mM/L)", settings: yLabelSettings.defaultVertical()))
        let yModel = ChartAxisModel(firstModelValue: 0, lastModelValue: 20, axisTitleLabel: ChartAxisLabel(text: "Glucose (mM/L)", settings: yLabelSettings.defaultVertical()), axisValuesGenerator: generator, labelsGenerator: yLabelGenerator)
        
        // generate axes layers and calculate chart inner frame, based on the axis models
        let chartFrame = self.chartView.frame
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerframe) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        
        // layer displays data-line
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor.blue, lineWidth: 3, animDuration: 1, animDelay: 0)
        let pointslineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel])
        
        // create Guideline Layer
        let glLSettings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.gray, linesWidth: 0.9)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: glLSettings)
        
        
        // label each point , -> now disabled
        let viewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsViewsLayer, chart: Chart) -> UIView? in
            let viewSize: CGFloat = 20
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
            innerFrame: innerframe,
            settings: ChartSettings.init(),
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                pointslineLayer,
                chartPointsLayer,
                chartPointsCircleLayer
                
            ]
        )
        view.addSubview(chart.view)
        self.chart = chart //as? LineChart
        
    }
    
    @objc func rotated() {
        for view in self.chartView.subviews {
            view.removeFromSuperview()
        }
        initChart()
    }
}
