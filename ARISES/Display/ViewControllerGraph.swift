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
    
    @IBOutlet weak var rightSideViewContainer: UIView!
    @IBOutlet weak var leftSideViewContainer: UIView!
    @IBOutlet weak var rightView: CustomView!
    @IBOutlet weak var rightView2: CustomView!
    @IBOutlet weak var rightView3: CustomView!
    @IBOutlet weak var leftView1: CustomView!
    @IBOutlet weak var leftView2: CustomView!
    @IBOutlet weak var leftView3: CustomView!
    @IBOutlet weak var leftView4: CustomView!

    
    //Gesture Recognisers
    @IBAction func rightGesture(_ sender: UISwipeGestureRecognizer) {
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
                             //"06/01/2016 19:50",
                             //"06/01/2016 22:43",
                             //"06/01/2016 23:37"
    ]
    
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
                               //4.5,
                               //6.6,
                               //10.3
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Second Transforms
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 500.0
        leftSideViewContainer.layer.transform = CATransform3DRotate(transform, CGFloat(-45 * Double.pi / 180), 0, 1, 0)
        rightSideViewContainer.layer.transform = CATransform3DRotate(transform, CGFloat(45 * Double.pi / 180), 0, 1, 0)
        
        // for rotating the chart when in horizontal view
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        //Adding data from arrays into core data
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let dayFormatter = DateFormatter()
        dayFormatter.dateStyle = .short
        dayFormatter.timeStyle = .none
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let tmpDate = dateFormatter.date(from: rawData[0])
        let tmpString = dayFormatter.string(from: tmpDate!)
        let tmpDay = dayFormatter.date(from: tmpString)
        
        let glucoseLogs = ModelController().fetchGlucose(day: tmpDay!) //produces array of glucose items
        if glucoseLogs == [] {
            for i in 0...(rawData.count - 1){
                let date = dateFormatter.date(from: rawData[i])
                let timeString = timeFormatter.string(from: date!)
                let dayString = dayFormatter.string(from: date!)
                let day = dayFormatter.date(from: dayString)
                ModelController().addGlucose(value: rawValues[i], time: timeString, date: day!)
            }
        }else {
            print("already loaded data in")
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !self.didLayout{
            self.didLayout = true
            self.initChart()
        }
    }
    
    var dataDict: [String: [customType]] = [:]
    
    
    private func calcRanges(Arr: [Double], view: CustomView){
        if Arr.count > 0 {
            view.dailyHigh = CGFloat(Arr.max()!)
            view.avgArrayValue = CGFloat(Arr.reduce(0, +) / Double(Arr.count))
            view.dailyLow = CGFloat(Arr.min()!)
        }else{
            view.dailyHigh = 0
            view.avgArrayValue = 0
            view.dailyLow = 0
        }
    }
    
    
    fileprivate lazy var chartSettings: ChartSettings = {
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
        return chartSettings
    }()
    
    
  
    
    private func initChart(){
        //map moel data to chart points
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd/MM/yyyy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "HH"
        
        
        //set function to today() when live code
        let day = dateFormatter.date(from: today)
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
        
        let todayArray = ModelController().fetchGlucose(day: day!)
        let todayFoodArray = ModelController().fetchMeals(day: day!)
        let todayInsulinArray = ModelController().fetchInsulin(day: day!)
        let todayExerciseArray = ModelController().fetchExercise(day: day!)
        let tMinus1Array = ModelController().fetchGlucose(day: tMinus1!)
        let tMinus2Array = ModelController().fetchGlucose(day: tMinus2!)
        let tMinus3Array = ModelController().fetchGlucose(day: tMinus3!)
        let tMinus4Array = ModelController().fetchGlucose(day: tMinus4!)
        let tPlus1Array = ModelController().fetchGlucose(day: tPlus1!)
        let tPlus2Array = ModelController().fetchGlucose(day: tPlus2!)
        let tPlus3Array = ModelController().fetchGlucose(day: tPlus3!)

        for item in tMinus4Array{
            if(item.value != 0){
                tMinus4Compare.append(item.value)
            }
        }
        
        for item in tMinus3Array{
            if(item.value != 0){
                tMinus3Compare.append(item.value)
            }
        }
        
        for item in tMinus2Array{
            if(item.value != 0){
                tMinus2Compare.append(item.value)
            }
        }

        for item in tMinus1Array{
            if(item.value != 0){
                tMinus1Compare.append(item.value)
            }
        }
        
        let prevItemTime = timeFormatter.date(from: "00:00")
        for item in todayArray{
            if(item.value != 0){
                let currItemTime = timeFormatter.date(from: item.time!)
                for meal in todayFoodArray{
                    //Checks that the meal time is between the current point and previous point tested
                    let mealTime = timeFormatter.date(from: meal.time!)
                    if(((mealTime!) < (currItemTime!)) && ((mealTime!) > (prevItemTime!))){
                        let combinedMealDate = keyDay + " " + meal.time!
                        print("Meal at this time: "+item.time!)
                        //Adds the meal as a point on graph
                        //Uses previous glucose reading instead of taking a new one (might want to change in future)
                        valueArray.append(ChartAxisValueDouble(item.value))
                        dateArray.append(ChartAxisValueDate(date: dateFormatter.date(from: combinedMealDate)!, formatter: dateFormatter))
                        points.append(ChartPoint(x: dateArray[dateArray.endIndex - 1], y: valueArray[valueArray.endIndex - 1]))
                    }
                }
                for exercise in todayExerciseArray{
                    let combinedExerciseDate = keyDay + " " + exercise.time!
                    let exerciseTime = timeFormatter.date(from: exercise.time!)
                    if(((exerciseTime!) < (currItemTime!)) && ((exerciseTime!) > (prevItemTime!))){
                        valueArray.append(ChartAxisValueDouble(item.value))
                        dateArray.append(ChartAxisValueDate(date: dateFormatter.date(from: combinedExerciseDate)!, formatter: dateFormatter))
                        points.append(ChartPoint(x: dateArray[dateArray.endIndex - 1], y: valueArray[valueArray.endIndex - 1]))
                    }
                }
                for insulin in todayInsulinArray{
                    let combinedInsulinDate = keyDay + " " + insulin.time!
                    let insulinTime = timeFormatter.date(from: insulin.time!)
                    if(((insulinTime!) < (currItemTime!)) && ((insulinTime!) > (prevItemTime!))){
                        valueArray.append(ChartAxisValueDouble(item.value))
                        dateArray.append(ChartAxisValueDate(date: dateFormatter.date(from: combinedInsulinDate)!, formatter: dateFormatter))
                        points.append(ChartPoint(x: dateArray[dateArray.endIndex - 1], y: valueArray[valueArray.endIndex - 1]))
                    }
                }
                let prevItemTime = timeFormatter.date(from: item.time!)
                let combinedDate = keyDay + " " + item.time!
                valueArray.append(ChartAxisValueDouble(item.value))
                dateArray.append(ChartAxisValueDate(date: dateFormatter.date(from: combinedDate)!, formatter: dateFormatter))
                points.append(ChartPoint(x: dateArray[dateArray.endIndex - 1], y: valueArray[valueArray.endIndex - 1]))
            }
        }
        
        
        
        //might just do comparison directly out of tPlus1Array
        for item in tPlus1Array{
            if(item.value != 0){
                tPlus1Compare.append(item.value)
            }
        }
        
        for item in tPlus2Array{
            if(item.value != 0){
                tPlus2Compare.append(item.value)
            }
        }
        
        for item in tPlus3Array{
            if(item.value != 0){
                tPlus3Compare.append(item.value)
            }
        }
        
        calcRanges(Arr: tMinus1Compare, view: leftView1)
        calcRanges(Arr: tMinus2Compare, view: leftView2)
        calcRanges(Arr: tMinus3Compare, view: leftView3)
        calcRanges(Arr: tMinus4Compare, view: leftView4)
        calcRanges(Arr: tPlus1Compare, view: rightView)
        calcRanges(Arr: tPlus2Compare, view: rightView2)
        calcRanges(Arr: tPlus3Compare, view: rightView3)
        
        
        let predictedGlucosePoints: [ChartPoint] = [("06/01/2016 18:27", 8.2), ("06/01/2016 19:30", 12), ("06/01/2016 20:00", 6), ("06/01/2016 20:30", 6), ("06/01/2016 21:00", 9), ("06/01/2016 21:30", 8), ("06/01/2016 22:00", 11), ("06/01/2016 22:10", 8), ("06/01/2016 22:40", 4), ("06/01/2016 23:10", 7), ("06/01/2016 23:57", 9)].map {
            return ChartPoint(
                x: ChartAxisValueDate(date: dateFormatter.date(from: $0.0)!, formatter: dateFormatter),
                y: ChartAxisValueDouble($0.1)
            )
        }
        //Something needs changing to initialise chart point
        let chartPoints = points
        let yLabelSettings = ChartLabelSettings(font: UIFont.systemFont(ofSize: 11))
        let xLabelSettings = ChartLabelSettings(font: UIFont.systemFont(ofSize: 8), fontColor: UIColor.black, rotation: 90, rotationKeep: .top)
        
        let xValues = ChartAxisValuesGeneratorDate(unit: .hour, preferredDividers: 8, minSpace: 0.5, maxTextSize: 12)
        
        // create axis models with axis values and axis title
        let startTime: Date? = dateFormatter.date(from: today)
        let endTime: Date? = Calendar.current.date(byAdding: .day, value: 1, to: startTime!)
        
        //Axis Labels
        let xLabelGenerator = ChartAxisLabelsGeneratorDate(labelSettings: xLabelSettings, formatter: hourFormatter)
        let yLabelGenerator = ChartAxisLabelsGeneratorNumber(labelSettings: yLabelSettings)
        let generator = ChartAxisGeneratorMultiplier(4)
        
        
        //Axis models
        let xModel = ChartAxisModel(firstModelValue: (startTime!.timeIntervalSince1970), lastModelValue: (endTime!.timeIntervalSince1970), axisTitleLabel: ChartAxisLabel(text: dayFormatter.string(from: startTime!), settings: yLabelSettings), axisValuesGenerator: xValues, labelsGenerator: xLabelGenerator)
        
        let yModel = ChartAxisModel(firstModelValue: 0, lastModelValue: 20, axisTitleLabel: ChartAxisLabel(text: "Glucose (mM/L)", settings: yLabelSettings.defaultVertical()), axisValuesGenerator: generator, labelsGenerator: yLabelGenerator)
        
        // generate axes layers and calculate chart inner frame, based on the axis models
        let chartFrame = self.chartView.frame
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerframe) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        
        // layer displays data-line
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor.blue, lineWidth: 3, animDuration: 1, animDelay: 0)
        let pointslineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel])

        
        //predication linemodel
        let lineModelPred = ChartLineModel(chartPoints: predictedGlucosePoints, lineColor: UIColor.red, lineWidth: 3, lineJoin: LineJoin.bevel, lineCap: LineCap.round, animDuration: 1, animDelay: 0, dashPattern: [5, 5])
        //var prediction: ChartLayer?
        let prediction = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModelPred])
        
        // create Guideline Layer
        let glLSettings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.gray, linesWidth: 0.9)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: glLSettings)
        
        
        // mark data points
        let circleViewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let circleView = ChartPointEllipseView(center: chartPointModel.screenLoc, diameter: 5)
            
            circleView.animDuration = 1.0
            circleView.fillColor = UIColor.red
            circleView.borderWidth = 0.9
            circleView.borderColor = UIColor.red
            circleView.isUserInteractionEnabled = true
            let w: CGFloat = 80
            let h: CGFloat = 60
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
                    
                    var text : String

                    
                    //attaches anything of note to the data point
                    print(chartPointModel.chartPoint.y.scalar)
                    if(chartPointModel.chartPoint.y.scalar > 11.1){
                        circleView.data = "Hyperglycemic"
                    }else if(chartPointModel.chartPoint.y.scalar < 3.9){
                        circleView.data = "Hypoglycemic"
                    }
                
                    
                    //Showing meal details on correct point click
                    
                    //Gets meals and times they were at to identify which point in the graph is the one where the meal was consumed
                    let meals = ModelController().fetchMeals(day: day!)
                    let exercises = ModelController().fetchExercise(day: day!)
                    let insulins = ModelController().fetchInsulin(day: day!)
                    let xVal = chartPointModel.chartPoint.x.scalar
                    let time = Date.init(timeIntervalSince1970: xVal)
                    let timeDate = timeFormatter.string(from: time)
                    
                    //searches through meals for the day for meals that align with data point on the graph in terms of time
                    for meal in meals{
                        if(meal.time == timeDate){
                            print("Carbs: " + String(meal.carbs))
                            circleView.data = "🍎"
                        }
                    }
                    
                    for exercise in exercises{
                        if(exercise.time == timeDate){
                             circleView.data = "🤾‍♀️"
                        }
                    }
                    
                    for insulin in insulins{
                        if(insulin.time == timeDate){
                            circleView.data = "💉"
                        }
                    }
            
                    
                    if circleView.data != nil{
                        text = circleView.data! + "\n"
                    }else{
                        text = ""
                    }
                    let font = UIFont.boldSystemFont(ofSize: 9)
                    if(text != ""){
                        let bu = InfoBubble(point: CGPoint(x: x, y: chartViewScreenLoc.y), preferredSize: CGSize(width: w, height: h), superview: self.view, text: text, font: font, textColor: UIColor.yellow)
                        chart.addSubview(bu)
                        if(text == "🍎"){
                            print("Meal")
                            //Ideally want to change it so that it displays macros when clicked of the meal
                        }else{
                            UIView.animate(withDuration: 3.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                                bu.alpha = 0.0
                            }, completion: {finished in bu.removeFromSuperview()})
                        }
                    }
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
                prediction,
                chartPointsCircleLayer
            ]
        )
        
        view.addSubview(chart.view)
        self.chart = chart
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

extension ChartPointEllipseView{
    private struct extra{
        static var data:String? = nil
    }
    
    var data:String?{
        get{
            return objc_getAssociatedObject(self, &extra.data) as? String
        }
        
        set{
            if let unwrappedData = newValue {
                objc_setAssociatedObject(self, &extra.data, unwrappedData as NSString?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
