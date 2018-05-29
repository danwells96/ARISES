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
    private var today: String = "6/01/2016 00:00"
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
    //fileprivate var popups: [UIView] = []
    
    @IBOutlet weak var rightSideViewContainer: UIView!
    @IBOutlet weak var leftSideViewContainer: UIView!
    @IBOutlet weak var rightView: CustomView!
    @IBOutlet weak var rightView2: CustomView!
    @IBOutlet weak var rightView3: CustomView!
    @IBOutlet weak var leftView1: CustomView!
    @IBOutlet weak var leftView2: CustomView!
    @IBOutlet weak var leftView3: CustomView!
    @IBOutlet weak var leftView4: CustomView!

    
    // // // TODO: add tag on top right corner to indicate date changes // // //
    
    //Gesture Recognisers
    @IBAction func rightGesture(_ sender: UISwipeGestureRecognizer) {
        //print("right")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let tempDate = dateFormatter.date(from: today)
        let tempDate2 = Calendar.current.date(byAdding: .day, value: -1, to: tempDate!)
        today = dateFormatter.string(from: tempDate2!)
        
        for view in (chart?.view.subviews)! {
            view.removeFromSuperview()
        }
        initChart()
        chart?.view.setNeedsDisplay()
        updateSideViews()
    }
    
    @IBAction func leftGesture(_ sender: UISwipeGestureRecognizer) {
        //print("left")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let tempDate = dateFormatter.date(from: today)
        let tempDate2 = Calendar.current.date(byAdding: .day, value: +1, to: tempDate!)
        today = dateFormatter.string(from: tempDate2!)

        for view in (chart?.view.subviews)! {
            view.removeFromSuperview()
        }
        initChart()
        chart?.view.setNeedsDisplay()
        updateSideViews()
    }

    private func updateSideViews(){
        leftView1.setNeedsDisplay()
        leftView2.setNeedsDisplay()
        leftView3.setNeedsDisplay()
        leftView4.setNeedsDisplay()
        rightView.setNeedsDisplay()
        rightView2.setNeedsDisplay()
        rightView3.setNeedsDisplay()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Second Transforms
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 500.0
        leftSideViewContainer.layer.transform = CATransform3DRotate(transform, CGFloat(-45 * Double.pi / 180), 0, 1, 0)
        
        rightSideViewContainer.layer.transform = CATransform3DRotate(transform, CGFloat(45 * Double.pi / 180), 0, 1, 0)
        
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
        print(today)
        var dateArray = [ChartAxisValueDate]()
        var valueArray = [ChartAxisValueDouble]()
        var points = [ChartPoint]()
        
        dateArray.removeAll()
        valueArray.removeAll()
        points.removeAll()
        tMinus1Compare.removeAll()
        tMinus2Compare.removeAll()
        tMinus3Compare.removeAll()
        tMinus4Compare.removeAll()
        tPlus1Compare.removeAll()
        tPlus2Compare.removeAll()
        tPlus3Compare.removeAll()

        
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
            
            switch key{
                case tMinus4String:
                    for val in value{
                        if(val.value != 0){
                            tMinus4Compare.append(val.value)
                        }
                    }
                case tMinus3String:
                    for val in value{
                        if(val.value != 0){
                            tMinus3Compare.append(val.value)
                        }
                    }
                case tMinus2String:
                    for val in value{
                        if(val.value != 0){
                            tMinus2Compare.append(val.value)
                        }
                    }
                case tMinus1String:
                    for val in value{
                        if(val.value != 0){
                            tMinus1Compare.append(val.value)
                        }
                    }
                case keyDay:
                    for val in value{
                        if(val.value != 0){
                            let combinedDate = key+" "+val.time
                            valueArray.append(ChartAxisValueDouble(val.value))
                            dateArray.append(ChartAxisValueDate(date: dateFormatter.date(from: combinedDate)!, formatter: dateFormatter))
                            points.append(ChartPoint(x: dateArray[dateArray.endIndex-1], y: valueArray[valueArray.endIndex-1]))
                        }
                    }
                case tPlus1String:
                    for val in value{
                        if(val.value != 0){
                            tPlus1Compare.append(val.value)
                        }
                    }
                case tPlus2String:
                    for val in value{
                        if(val.value != 0){
                            tPlus2Compare.append(val.value)
                        }
                    }
                case tPlus3String:
                    for val in value{
                        if(val.value != 0){
                            tPlus3Compare.append(val.value)
                        }
                    }
                default:
                    print("Data not needed")
            }
        }
        
        if(tMinus1Compare.count > 0){
            leftView1.dailyHigh = CGFloat(tMinus1Compare.max()!)
            leftView1.avgArrayValue = CGFloat(tMinus1Compare.reduce(0, +) / Double(tMinus1Compare.count))
            leftView1.dailyLow = CGFloat(tMinus1Compare.min()!)
        }else{
            leftView1.dailyHigh = 0
            leftView1.avgArrayValue = 0
            leftView1.dailyLow = 0
        }
        
        if(tMinus2Compare.count > 0){
            leftView2.dailyHigh = CGFloat(tMinus2Compare.max()!)
            leftView2.avgArrayValue = CGFloat(tMinus2Compare.reduce(0, +) / Double(tMinus2Compare.count))
            leftView2.dailyLow = CGFloat(tMinus2Compare.min()!)
        }else{
            leftView2.dailyHigh = 0
            leftView2.avgArrayValue = 0
            leftView2.dailyLow = 0
        }
        
        if(tMinus3Compare.count > 0){
            leftView3.dailyHigh = CGFloat(tMinus3Compare.max()!)
            leftView3.avgArrayValue = CGFloat(tMinus3Compare.reduce(0, +) / Double(tMinus3Compare.count))
            leftView3.dailyLow = CGFloat(tMinus3Compare.min()!)
        }else{
            leftView3.dailyHigh = 0
            leftView3.avgArrayValue = 0
            leftView3.dailyLow = 0
        }
        
        
        
        if(tMinus4Compare.count > 0){
            leftView4.dailyHigh = CGFloat(tMinus4Compare.max()!)
            leftView4.avgArrayValue = CGFloat(tMinus4Compare.reduce(0, +) / Double(tMinus4Compare.count))
            leftView4.dailyLow = CGFloat(tMinus4Compare.min()!)
        }else{
            leftView4.dailyHigh = 0
            leftView4.avgArrayValue = 0
            leftView4.dailyLow = 0
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
        
        
        // mark data points
        let circleViewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let circleView = ChartPointEllipseView(center: chartPointModel.screenLoc, diameter: 7)
            
            circleView.animDuration = 1.0
            circleView.fillColor = UIColor.red
            circleView.borderWidth = 0.9
            circleView.borderColor = UIColor.red
            circleView.isUserInteractionEnabled = true
            let w: CGFloat = 50
            let h: CGFloat = 30
            circleView.touchHandler = {
                
                if let chartViewScreenLoc = layer.containerToGlobalScreenLoc(chartPointModel.chartPoint) {
                    let x: CGFloat = {
                        let attempt = chartViewScreenLoc.x - (w/2)
                        let leftBound: CGFloat = chart.bounds.origin.x
                        let rightBound = chart.bounds.size.width - 5
                        if attempt < leftBound {
                            return chart.view.frame.origin.x
                        } else if attempt + w > rightBound {
                            return rightBound - w
                        }
                        return attempt
                    }()
                    
                    let frame = CGRect(x: x, y: chartViewScreenLoc.y - (h + (Env.iPad ? 30 : 6)), width: w, height: h)
                    let bubbleView = InfoBubble(point: chartViewScreenLoc, frame: frame, arrowWidth: Env.iPad ? 40 : 6, arrowHeight: Env.iPad ? 20 : 4, bgColor: UIColor.black, arrowX: chartViewScreenLoc.x - x, arrowY: -1)
                    //let mmm = InfoBubble(point: chartViewScreenLoc, preferredSize: CGSize(width: <#T##CGFloat#>, height: <#T##CGFloat#>), superview: <#T##UIView#>, text: <#T##String#>, font: <#T##UIFont#>, textColor: <#T##UIColor#>)
                   
                    chart.view.addSubview(bubbleView)

                    let infoView = UILabel(frame: CGRect(x: 0, y: 10, width: w, height: h - 15))
                    infoView.textColor = UIColor.white
                    infoView.backgroundColor = UIColor.black
                    infoView.text = "text......"
                    infoView.font = UIFont.boldSystemFont(ofSize: 10)
                    infoView.textAlignment = NSTextAlignment.center

                    bubbleView.addSubview(infoView)
                    
                    UIView.animate(withDuration: 3.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                        bubbleView.alpha = 0.0
                        infoView.alpha = 0.0
                        
                    }, completion: nil)
                }
            }
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

class Env {
    
    static var iPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}


