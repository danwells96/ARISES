//
//  ViewControllerGraph.swift
//  ARISES
//  This file deals with everything graph related. Base chart library (Podfile): https://github.com/i-schuetz/SwiftCharts.git

//  Created by Ryan Armiger on 16/05/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit
import Foundation
import SwiftCharts

class ViewControllerGraph: UIViewController {

    //MARK: Chart Area Variables
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
    
    @IBOutlet weak var Basal: UIImageView!
    @IBOutlet var rightGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var leftGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet weak var pickerTextField: UITextField!
    let picker = UIDatePicker()
    @IBOutlet weak var currentGlucose: UILabel!
    
    //Actions: swpie to bring side data to the centre
    @IBAction func rightGesture(_ sender: UISwipeGestureRecognizer) {
        let tempDate = today
        let tempDate2 = Calendar.current.date(byAdding: .day, value: -1, to: tempDate)
        today = tempDate2!
        updateDay()
        updateViews()
    }
    @IBAction func leftGesture(_ sender: UISwipeGestureRecognizer) {
        let tempDate = today
        let tempDate2 = Calendar.current.date(byAdding: .day, value: +1, to: tempDate)
        today = tempDate2!
        updateDay()
        updateViews()
    }
    
    
    
    /// tmp variable till real-time data available
    var today = Calendar.current.startOfDay(for: Date())
    
    /// Declares Notifications
    let nc = NotificationCenter.default
    
    /* arrays storing sideviews' data: (Minus -> leftView, Plus -> rightView)  */
    var tMinus1Compare : [Double] = []
    var tMinus2Compare : [Double] = []
    var tMinus3Compare : [Double] = []
    var tPlus1Compare : [Double] = []
    var tPlus2Compare : [Double] = []
    var tPlus3Compare : [Double] = []
    
    
    /// Array storing date and time info needed for plot. To be updated with real-time data.
    var rawData: [String] = ["10/06/2018 2:30", "10/06/2018 6:30", "10/06/2018 7:30", "10/06/2018 8:30", "10/06/2018 9:30",
                             "10/06/2018 14:00","10/06/2018 16:30", "10/06/2018 18:30", "10/06/2018 20:30", "10/06/2018 22:30",
                             
                             "11/06/2018 4:00", "11/06/2018 6:30", "11/06/2018 8:00", "11/06/2018 9:00","11/06/2018 11:00", "11/06/2018 13:30", "11/06/2018 14:00", "11/06/2018 16:30", "11/06/2018 20:30", "11/06/2018 22:00",
                             
                             "12/06/2018 00:30", "12/06/2018 02:30", "12/06/2018 04:00", "12/06/2018 05:00", "12/06/2018 06:00", "12/06/2018 08:00", "12/06/2018 10:00", "12/06/2018 12:00", "12/06/2018 15:00", "12/06/2018 17:00", "12/06/2018 18:00", "12/06/2018 20:00", "12/06/2018 22:00", "12/06/2018 23:00",
                             
                             "13/06/2018 01:00", "13/06/2018 02:00", "13/06/2018 06:00", "13/06/2018 08:00", "13/06/2018 09:00", "13/06/2018 10:00",
                             "13/06/2018 11:30", "13/06/2018 13:30", "13/06/2018 14:00", "13/06/2018 16:00", "13/06/2018 18:30", "13/06/2018 20:00",

                             "13/06/2018 22:00", "13/06/2018 23:59",
                             
                             "14/06/2018 00:00", "14/06/2018 03:00", "14/06/2018 06:00", "14/06/2018 09:00", "14/06/2018 12:00",
                             
                             ]

    
    /// Array storing past glucose measurements. To be updated with real-time data from wearables.
    var rawValues: [Double] = [12, 12.8, 12.7, 10.8, 9.3, 7.5, 8, 6, 8.7, 14.5,
                               
                               10, 12, 11.6, 11.1, 7.7, 2.8, 2.7, 3.8, 13.6, 5,
                               
                               8.4, 8, 7.4, 7, 7.3, 8.9, 8.5, 7.5, 9, 5.6, 8.4, 9, 7.4, 7.5,

                               5, 4, 4, 4, 5.7, 4.6, 4.6, 5.8, 5.5, 4.6, 6.4, 4.6, 4.5, 4.1,
                               
                               5, 8, 8.7, 9, 7.6,
                               
                               ]

    /**
	*	This function is an override of the same function in the superclass which is called after the view has loaded. It calls the functions 
	*	responsible for rotating the sideView containers, creating the DatePicker, update any settings and add the notification listeners.
	*	
	*	- Returns: Null
	*/
    override func viewDidLoad() {
        /* In this func:
         Transform sideView containers into bifocal. Load tmp arrays into CoreData.
         Show date picker.  Update settings.  Update popups.
         */
        super.viewDidLoad()
        sideTransforms()
        loadData()
        createDatePicker()
        settingPreferences()
        addNotifications()
    
        /*
        // Pan gesture not in use
         let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.pannedView(sender:)))
         panRecognizer.require(toFail: leftGestureRecognizer)
         panRecognizer.require(toFail: rightGestureRecognizer)
         chartView.addGestureRecognizer(panRecognizer)
        */
    }
	
	
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !self.didLayout{
            self.didLayout = true
            self.initChart()
        }
    }
    
    /*
     /// for when pan gesture is enabled
     var startLocation = CGPoint()
     @objc func pannedView(sender:UIPanGestureRecognizer){
     if(sender.state == UIGestureRecognizerState.began){
     print("Started pan")
     startLocation = sender.location(in: self.view)
     }else if(sender.state == UIGestureRecognizerState.ended){
     print("Finished")
     let stopLocation = sender.location(in: self.view)
     let dy = startLocation.y - stopLocation.y
     print(dy)
     }else if(sender.state == UIGestureRecognizerState.changed){
     print("location: \(sender.location(in: self.view))")
     }
     }
    */
    
    
    /**
	*	Loads data from arrays into core data on first launch for test purposes
	*
	*	- Returns: Null
	*/
    func loadData(){
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
        
        //Fetches array of glucose items on from the first day of the array to check if the array has been added to Core Data yet.
        let glucoseLogs = ModelController().fetchGlucose(day: tmpDay!)
        if glucoseLogs.count == 0{
            for i in (glucoseLogs.count)...(rawData.count - 1){
                let date = dateFormatter.date(from: rawData[i])
                let timeString = timeFormatter.string(from: date!)
                let dayString = dayFormatter.string(from: date!)
                let day = dayFormatter.date(from: dayString)
                ModelController().addGlucose(value: rawValues[i], time: timeString, date: day!)
            }
        }else {
            print("Already loaded data in")
        }
    }
    
    
    /**
	*	Rotates the sideView Containers by (+/-)45degrees about the y axis to give the impression of perspective.
	*
	*	- Returns: Null
	*/
    func sideTransforms(){
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 500.0
        leftSideViewContainer.layer.transform = CATransform3DRotate(transform, CGFloat(-45 * Double.pi / 180), 0, 1, 0)
        rightSideViewContainer.layer.transform = CATransform3DRotate(transform, CGFloat(45 * Double.pi / 180), 0, 1, 0)
    }
    
    
    /// Notifications for when events are added
    func addNotifications(){
        nc.addObserver(self, selector: #selector(dataUpdated), name: Notification.Name("FoodAdded"), object: nil)
        nc.addObserver(self, selector: #selector(dataUpdated), name: Notification.Name("ExerciseAdded"), object: nil)
        nc.addObserver(self, selector: #selector(dataUpdated), name: Notification.Name("InsulinAdded"), object: nil)
        nc.addObserver(self, selector: #selector(setDay(notification:)), name: Notification.Name("setDay"), object: nil)
    }
	
	/// Called when a notification is received after food, exercise or insulin has been added to Core Data. 
	/// It reloads the chart data and displays it.
    @objc private func dataUpdated(){
        initChart()
        chart?.view.setNeedsDisplay()
    }

    
    /// Registers settings bundle. Creates a Notification Listener to detect when a change has been made to the Settings.
    func settingPreferences(){
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewControllerGraph.defaultsChanged), name: UserDefaults.didChangeNotification, object: nil)
        defaultsChanged()
    }
	
	/// Detects which changes that have been made to the Settings and apply them to the UI.
    @objc func defaultsChanged(){
        if(UserDefaults.standard.bool(forKey: "showBasalPreference")){
            Basal.isHidden = false
        }else if(!(UserDefaults.standard.bool(forKey: "showBasalPreference"))){
            Basal.isHidden = true
        }
    }
    
    
    /**
    *	Function called when a Notification is detected upon the date being changed. Used to synchronize the app.
    *	- Parameter notification: Notification, detected by NotificationCenter's observer.
    */
    @objc func setDay(notification: Notification){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none

        let dayToSet = notification.object as! String
        today = dateFormatter.date(from: dayToSet)!

        updateDay()
        updateViews()
    }
	
	/// Creates a Notification used to synchronize the Date throughout the app.
    func updateDay(){
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("dayChanged"), object: today)
    }
    
    
    /**
	*	Re-initializes the chart and sideViews with the new data corresponding to the updated Date.
    */
    private func updateViews(){
        for view in (chart?.view.subviews)! {
            view.removeFromSuperview()
        }
        initChart()
        chart?.view.setNeedsDisplay()
        leftView1.setNeedsDisplay()
        leftView2.setNeedsDisplay()
        leftView3.setNeedsDisplay()
        rightView.setNeedsDisplay()
        rightView2.setNeedsDisplay()
        rightView3.setNeedsDisplay()
    }
    

    
    /**
	*	Takes the date as argument and converts it to the format 'weekday day month, year'
    * - Parameter date: Date to be transformed
    * - Returns: String, date in required string format
    */
    func formatWeekday(date: Date){
        let weekdayFormatter = DateFormatter()
        weekdayFormatter.dateFormat = "EEEE dd MMMM, yyyy"
        pickerTextField.text = weekdayFormatter.string(from:date)
        pickerTextField.sizeToFit()
    }
    
    
    /**
    * Create a date picker and formats the date as required and displays it.
    */
    func createDatePicker(){
        
        formatWeekday(date: Date())  //PLACEHOLDER
        picker.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        pickerTextField.inputAccessoryView = toolbar
        pickerTextField.inputView = picker
    }
	
	///	Function called after the user has finished with the DatePicker and synchronizes the date used for the chart with the viewController.
    @objc func donePressed(){
        formatWeekday(date: picker.date)
        self.view.endEditing(true)

        today = Calendar.current.startOfDay(for: picker.date)
        updateDay()
        picker.date = Date()
        updateViews()
    }
    
    
    
    /**
     Calculates the minimum, maximum and mean average for daily glucose measurements and updates the CustomView's member data.
     - Parameter Arr: Double Array, Glucose measurements for a day.
     - Parameter view: CustomView, to be updated with calculated values.
     */
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
    
    
    ///Frame settings for chart area and axis.
    fileprivate lazy var chartSettings: ChartSettings = {
        var chartSettings = ChartSettings()
        chartSettings.leading = -15
        chartSettings.top = 10
        chartSettings.trailing = 10
        chartSettings.bottom = 10
        chartSettings.labelsToAxisSpacingX = 5
        chartSettings.labelsToAxisSpacingY = 5
        chartSettings.axisTitleLabelsToLabelsSpacing = 4
        chartSettings.axisStrokeWidth = 0.2
        chartSettings.spacingBetweenAxesX = 8
        chartSettings.spacingBetweenAxesY = 10
        chartSettings.labelsSpacing = 0
        return chartSettings
    }()
    
    
    /**
    *	Plot glucose, meals, exercise, insulin and predicted glucose data in Layers to create the chart featured in the Bifocal Display.
    *	Draws popups and attach messages to them based on Core Data.
    *	Change of dates gets passed in to update chart.
    */
    private func initChart(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd/MM/yyyy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "H"
        
        //set function to today() when live code
        let day = today
        var dateArray = [ChartAxisValueDate]()
        var valueArray = [ChartAxisValueDouble]()
        
        ///glucose data points array
        var points = [ChartPoint]()
        
        ///popup points array
        var extraPoints = [ChartPoint]()
        var predictedGlucosePoints: [ChartPoint] = []
        ///last points in points array
        var nowIndicator: ChartPoint
        
        points.removeAll()
        dateArray.removeAll()
        valueArray.removeAll()
        extraPoints.removeAll()
        tMinus1Compare.removeAll()
        tMinus2Compare.removeAll()
        tMinus3Compare.removeAll()
        tPlus1Compare.removeAll()
        tPlus2Compare.removeAll()
        tPlus3Compare.removeAll()
        
        //Dates for sideviews calculated
        let tMinus1 = Calendar.current.date(byAdding: .day, value: -1, to: day)
        let tMinus2 = Calendar.current.date(byAdding: .day, value: -2, to: day)
        let tMinus3 = Calendar.current.date(byAdding: .day, value: -3, to: day)
        let tPlus1 = Calendar.current.date(byAdding: .day, value: 1, to: day)
        let tPlus2 = Calendar.current.date(byAdding: .day, value: 2, to: day)
        let tPlus3 = Calendar.current.date(byAdding: .day, value: 3, to: day)
        
        //Fetch past data for glucose, meals, and exercises:
        let todayArray = ModelController().fetchGlucose(day: day)
        let todayFoodArray = ModelController().fetchMeals(day: day)
        let todayInsulinArray = ModelController().fetchInsulin(day: day)
        let todayExerciseArray = ModelController().fetchExercise(day: day)
        
        //Fetch past data for required dates -> for sideViews
        let tMinus1Array = ModelController().fetchGlucose(day: tMinus1!)
        let tMinus2Array = ModelController().fetchGlucose(day: tMinus2!)
        let tMinus3Array = ModelController().fetchGlucose(day: tMinus3!)
        let tPlus1Array = ModelController().fetchGlucose(day: tPlus1!)
        let tPlus2Array = ModelController().fetchGlucose(day: tPlus2!)
        let tPlus3Array = ModelController().fetchGlucose(day: tPlus3!)
        
       //get non-zero Glucose values for calculation
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
        
        //struct points for plotting on main graph
        let keyDay = dayFormatter.string(from: day)
        for item in todayArray{
            if(item.value != 0){
                let combinedDate = keyDay + " " + item.time!
                valueArray.append(ChartAxisValueDouble(item.value))
                dateArray.append(ChartAxisValueDate(date: dateFormatter.date(from: combinedDate)!, formatter: dateFormatter))
                points.append(ChartPoint(x: dateArray[dateArray.endIndex - 1], y: valueArray[valueArray.endIndex - 1]))
            }
        }
        points.sort(by: {$0.x.scalar < $1.x.scalar})   //sort points by time
        
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
        calcRanges(Arr: tPlus1Compare, view: rightView)
        calcRanges(Arr: tPlus2Compare, view: rightView2)
        calcRanges(Arr: tPlus3Compare, view: rightView3)
        
        
        // y-position of activity POPUPs on the graph:
        for meal in todayFoodArray{
            let combinedDate = keyDay + " " + meal.time!
            extraPoints.append(ChartPoint(x: ChartAxisValueDate(date: dateFormatter.date(from: combinedDate)!, formatter: dateFormatter), y: ChartAxisValueInt(Int(meal.carbs))))
        }
        
        for exercise in todayExerciseArray{
            let combinedDate = keyDay + " " + exercise.time!
            extraPoints.append(ChartPoint(x: ChartAxisValueDate(date: dateFormatter.date(from: combinedDate)!, formatter: dateFormatter), y: ChartAxisValueDouble(5.0)))
        }
        
        for insulin in todayInsulinArray{
            let combinedDate = keyDay + " " + insulin.time!
            extraPoints.append(ChartPoint(x: ChartAxisValueDate(date: dateFormatter.date(from: combinedDate)!, formatter: dateFormatter), y: ChartAxisValueDouble(195.0)))
        }
        extraPoints.sort(by: {$0.x.scalar < $1.x.scalar})   //sort pop-ups after events added
        
        
        //Axis Labels settings
        let yLabelSettings = ChartLabelSettings(font: UIFont.systemFont(ofSize: 9))
        let xLabelSettings = ChartLabelSettings(font: UIFont.systemFont(ofSize: 8), fontColor: UIColor.black, rotation: 0, rotationKeep: .top)
        let yLabelSettingsCarbs = ChartLabelSettings(font: UIFont.systemFont(ofSize: 0))
        var carbChartSettings = chartSettings
        carbChartSettings.axisStrokeWidth = 0   //Removes carb axis from chart
        
        //Generate axis labels
        let xValues = ChartAxisValuesGeneratorDate(unit: .hour, preferredDividers: 4, minSpace: 0.5, maxTextSize: 12)
        let xLabelGenerator = ChartAxisLabelsGeneratorDate(labelSettings: xLabelSettings, formatter: hourFormatter)
        let yLabelGenerator = ChartAxisLabelsGeneratorNumber(labelSettings: yLabelSettings)
        let generator = ChartAxisGeneratorMultiplier(4)
        let yLabelGeneratorCarbs = ChartAxisLabelsGeneratorNumber(labelSettings: yLabelSettingsCarbs)
        
        
        //Create axis models with axis values
        let startTime: Date? = Calendar.current.startOfDay(for: today)
        let endTime: Date? = Calendar.current.date(byAdding: .day, value: 1, to: startTime!)
        
        let xModel = ChartAxisModel(firstModelValue: (startTime!.timeIntervalSince1970), lastModelValue: (endTime!.timeIntervalSince1970), axisTitleLabel: ChartAxisLabel(text: "", settings: yLabelSettings), axisValuesGenerator: xValues, labelsGenerator: xLabelGenerator)
        
        let yModel = ChartAxisModel(firstModelValue: 0, lastModelValue: 20, axisTitleLabel: ChartAxisLabel(text: "", settings: yLabelSettings.defaultVertical()), axisValuesGenerator: generator, labelsGenerator: yLabelGenerator)
        
        let yHighModels = ChartAxisModel(firstModelValue: 0, lastModelValue: 200, axisTitleLabel: ChartAxisLabel(text: "", settings: yLabelSettings.defaultVertical()), axisValuesGenerator: ChartAxisGeneratorMultiplier(200), labelsGenerator: yLabelGeneratorCarbs)
        
        //Change date title accordingly
        formatWeekday(date: startTime!)
        
        
        //let currGlucose = nowIndicator.y.scalar
        currentGlucose.text = "6.0"
        currentGlucose.sizeToFit()
        
        // Generate Axes layers and calculate chart innerframe
        let chartFrame = self.chartView.frame
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let coordsSpaceCarbs = ChartCoordsSpaceRightBottomSingleAxis(chartSettings: carbChartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yHighModels)
        let (xAxisLayer, yAxisLayer, innerframe, yHighAxes) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame, coordsSpaceCarbs.yAxisLayer)

        //Guideline Layer
        let glLSettings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.gray, linesWidth: 0.9)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: glLSettings)
        
        // Datalines Layer
        let lineModel = ChartLineModel(chartPoints: points, lineColor: UIColor.blue, lineWidth: 3, animDuration: 1, animDelay: 0)
        let lineModelExtra = ChartLineModel(chartPoints: extraPoints, lineColor: UIColor.clear, lineWidth: 3, animDuration: 1, animDelay: 0)
        let pointslineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel, lineModelExtra])
        
        //Add prediction points when appropriate
        let nowString = dayFormatter.string(from: Date())
        let nowDate = dayFormatter.date(from: nowString)
        if(day == nowDate){
            predictedGlucosePoints = [(nowString + " 18:27", 9), (nowString + " 19:30", 9.8), (nowString + " 20:00", 10.2)].map {
                return ChartPoint(
                    x: ChartAxisValueDate(date: dateFormatter.date(from: $0.0)!, formatter: dateFormatter),
                    y: ChartAxisValueDouble($0.1)
                )
            }
        }
        //pred made continuous with non-empty arr
        if(points.count > 0){
            nowIndicator = points.last!
        }else{
            nowIndicator = ChartPoint(x: ChartAxisValueDate(date: today, formatter: dateFormatter), y: ChartAxisValueDouble(6))
        }
        predictedGlucosePoints.insert(nowIndicator, at: 0)
        
        /////////////////// draw predcted range ? ////////////////////
        let sortedGlucose = predictedGlucosePoints.sorted {(obj1, obj2) in return obj1.y.scalar < obj2.y.scalar}
        let lowPoint = sortedGlucose.first!
        let predictedLow: [ChartPoint] = [nowIndicator, lowPoint]
        let HighPoint = sortedGlucose.last!
        let predictedHigh: [ChartPoint] = [nowIndicator, HighPoint]
        
        
        //Prediciton Layer w/ ranges
        let newColor = UIColor(red: 0.6, green: 0.5, blue: 1, alpha: 1)
        let lineModelPred = ChartLineModel(chartPoints: predictedGlucosePoints, lineColor: UIColor.red, lineWidth: 3, lineJoin: LineJoin.bevel, lineCap: LineCap.round, animDuration: 1, animDelay: 0, dashPattern: [5, 5])
        let lineModelLow = ChartLineModel(chartPoints: predictedLow, lineColor: newColor, lineWidth: 1.5, animDuration: 1, animDelay: 0, dashPattern: [2, 2])
        let lineModeHigh = ChartLineModel(chartPoints: predictedHigh, lineColor: newColor, lineWidth: 1.5, animDuration: 1, animDelay: 0, dashPattern: [2, 2])
        let prediction = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModelPred, lineModelLow, lineModeHigh])
        
        
        //POPUPS Layer
        ///Instant popups on the graph for when activities added. Detailed meassages shown when points tapped.
        let circleViewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let circleView = ChartPointEllipseView(center: chartPointModel.screenLoc, diameter: 12)
            circleView.animDuration = 1.0
            circleView.fillColor = #colorLiteral(red: 0.9764705882, green: 0.6235294118, blue: 0.2196078431, alpha: 1)
            circleView.borderColor = UIColor.clear
            circleView.borderWidth = 0.9
            circleView.isUserInteractionEnabled = true
            let w: CGFloat = 80            //TODO: Change w and h depending on text size
            let h: CGFloat = 60
            var text : String = ""
            let font = UIFont.boldSystemFont(ofSize: 12)
            
            // Gets meals and times they were at on selected day
            let meals = ModelController().fetchMeals(day: day)
            let exercises = ModelController().fetchExercise(day: day)
            let insulins = ModelController().fetchInsulin(day: day)
            let xVal = chartPointModel.chartPoint.x.scalar
            let time = Date.init(timeIntervalSince1970: xVal)
            let timeDate = timeFormatter.string(from: time)
            
            //searches through activities and align popup with data point in terms of time for the day
            for meal in meals{
                if(meal.time! == timeDate){
                    circleView.data = "🍎"
                    text = "C:\(meal.carbs) P:\(meal.protein) F:\(meal.fat)"
                    circleView.fillColor = #colorLiteral(red: 0.9764705882, green: 0.6235294118, blue: 0.2196078431, alpha: 1)
                }
            }
            for exercise in exercises{
                if(exercise.time == timeDate){
                    circleView.data = "🤾‍♀️"
                    text = "\(exercise.name!): \(exercise.duration!)"
                    circleView.fillColor = #colorLiteral(red: 0, green: 0.6383251441, blue: 1, alpha: 1)
                }
            }
            for insulin in insulins{
                if(insulin.time == timeDate){
                    circleView.data = "💉"
                    text = "Insulin: \(insulin.units) units"
                    circleView.fillColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                }
            }
            
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
                    
                    if(circleView.data != ""){
                        let bu = InfoBubble(point: CGPoint(x: x + (24), y: chartViewScreenLoc.y), preferredSize: CGSize(width: w, height: h), superview: self.view, text: text, font: font, textColor: UIColor.white)
                        chart.addSubview(bu)
                        
                        if((circleView.data == "🍎") || (circleView.data == "🤾‍♀️") || (circleView.data == "💉")){
                            UIView.animate(withDuration: 5.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                                bu.alpha = 0.0
                            }, completion: {finished in bu.removeFromSuperview()})
                        }
                    }
                }
            }
            
            return circleView
        }
        let chartPointsCircleLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yHighAxes.axis, chartPoints: extraPoints, viewGenerator: circleViewGenerator, displayDelay: 0, delayBetweenItems: 0.05, mode: .translate)
        
        
        //Create chart instance with frame and layers
        let chart = Chart(
            view: self.chartView!,
            innerFrame: innerframe,
            settings: ChartSettings.init(),
            layers: [xAxisLayer,
                     yAxisLayer,
                     yHighAxes,
                     guidelinesLayer,
                     pointslineLayer,
                     prediction,
                     chartPointsCircleLayer
            ]
        )
        
        view.addSubview(chart.view)
        self.chart = chart
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
