# Bifocal Display Breakdown

<p align="center">
	<img src="Bifocal.png" alt="Image of Bifocal"/>
</p>



### Functionalities
* The most important infomation gets displayed on the main graph while less relevant data is displayed on the side views. 

* Scrolling left and right allows users to change the day's data which is being viewed in more detail.

* The *Add Insulin* icon on the top right corner allows user to add insulin.

* The *Settings* icon on the top left allows the user to go to the settings page and make changes to the application.

* *DatePicker* allows user the current date they are visualising. When tapped user can navigate to another day.

* When the graph is currently not on today, tap on *DatePicker* where the default popup date is set to today and click on that would take the user back to today.

* **The main graph:** 
  * Shows monitored glucose level on a day (to be taken from patients' wearables).
  
  * To keep the graph area as clean as possible the time interval displayed on the x axis is set to 6 hours.
  
  * Daily meals, execises and insulin dosage are updated on the main graph as soon as they are logged. Users can keep track on what time they did those activities. 
  
  * Messages of detailed information can be obtained when points are tapped. 

    * A popup message displaying the amount of carbs, protein and fats associated with each meal will appear when you tap on a meal point. 

    * A message for exercise would include exercise's name, duration and intensity. 

    * An insulin message states how many units of insulin were logged and the time administered.

* **The sideviews:** 
	* Shows the range and mean average of blood glucose levels for the user on that particular day.


## ChartBase Setup
The bifocal display consists of three parts: 
  * Leftside view container
  * Main graph section
  * Rightside view container

## Left & Right Sideview Containers
Each of the side view containers has three subviews of type CustomView (UIView) which are customized to show colours bands as a background. 
#### *ChartBGView.swift* and *CustomView.swift*
The same colour bands are used on the main chart as well thus *ChartBGView.swift* follows the same logic as the *CustomView.swift* in term of filling the background color bands. But *CustomView.swift* is also used to draw range bars on each sideview using calculated values for glucose values storing in core data on a day.

###### Bands calculations
The bands are calculated based on glucose level. If the total height of the Custom View is considered as an equivalent glucose level of 20 (mM/)L  then a 'safe'[[1]](https://www.niddk.nih.gov/health-information/diabetes/overview/preventing-problems/low-blood-glucose-hypoglycemia) range for patients to stay in would be between 4 and 10. Above 10 would be classified as a hyper and below 4 would be seen as a hypo.

Therefore, the top half of chart would be in **high** range, the bottom 4/20 (20%) of chart would be in **low** range and 6/20 (~30%)section in the middle would be of normal. 

The high and low bands are coloured differently to draw users attention. Colour palette here is simple and can be modified. (Colour combinations particularly red & green are avoided as diabetes suffering from retinopathy have problems distinguishing between them.)

#### *drawMiddleBand()*
* **Description:**
This function draws a rectangle with orgin (0,0) - top left corner, and extends itself to the reqired height (30% of total height). After it draws/marks, it colours the marked area with selected color.

* **Returns:**
This would give the background of image below (without the range bars).

<p align="center">
	<img src="sideview.png" alt="Image of sideview"/>
</p>

    
#### *drawRangeBar()*
* **Description:**
This function is created to draw maximun and minimum dashes as well as the average circle on side views. 
It uses UIBezierPath() as a drawing tool. Both line width and stroke colour can be set using this method.

* **Parameter:**
It takes no parameters but the output of sorting the glucose array on certain day would gives maximum and minimum. The difference  in heights of maximum & minimum with respect to glucose level of 20(mM/L) would be the stroke length of the range bar.

* **Returns:** An UIView with a drawn range bar

A view it creates would be: 
<p align="center">
	<img src="rangeBar.png" alt="Image of range bar"/>
</p>



## Main graph section

### *ViewControllerGraph.swift*
In this section we do everything graph related. For example:
* Transform sideView containers into bifocal. 
* Load tmp arrays into Core Data.
* Show date picker.  
* Update settings.  
* Update popups and attached messages.


Modifications are made on top of an iOS chart library which can be found here: https://github.com/i-schuetz/SwiftCharts.git 

* Layers: xAxisLayer, yAxisLayer, yHighAxes, guidelinesLayer, pointslineLayer, prediction, chartPointsCircleLayer

**xAxisLayer** conatins x-axis model and x-axis label settings. It displays time in a day with an interval of 6 hours thus 4 dividers.

**yAxisLayer** conatins glucose axis model and label settings. The axis ranges from 0 to 20 (mM/L) with an interval of 4. 

**yHighAxes** contains an invisible carbs axis on the right side of chart. Meals popups are plotted based on carbs axis and shares the same x-axis with glucose points.

**guidelinesLayer** provides dotted grid lines on graph

**pointslineLayer** draws glucose curve on graph in a solid blue line

**prediction** predicts patient's glucose in the next half an hour (now only tested with fixed data points)

**chartPointsCircleLayer** is where popups are set up. It has a touchHandler to deal with touch events which is to print a message based on the points being tapped.

The touchHandler detects where the finger tapped on the screen and compares the x-position of the touch with x coordinates of popups it stored. If they match or close to a certain degree the infoBubble is enabled which prints a message to user. If touches happens outside screen frame it returns the edge cases.
#### Functions below this line
---

Methods implemented are: 
#### *rightGesture* 
* **Description:** An IBAction func. Once a right swpie gesture is detected, main graph would be replaced by data from one day on the LHS. All other views update accordingly. (Everything shifts to the right)

* **Parameter:** The sender is UISwipeGestureRecognizer

#### *leftGesture* 
* **Description:** An IBAction func. Similar to rightGesture but detects left swipes. When a left swipe is made, it bring RHS data to the centre. (Everything shifts left) 

* **Parameter:** The sender is UISwipeGestureRecognizer

#### *sideTransforms()*
* **Description:** Skews the sideView containers into Bifocal shape. Left view container is 3D rotated 45 degrees around y - axis and right view container is rotated by -45 degrees.

* **Output:** The reshaped version of sideViews as required by clients

#### *loadData()*
* **Description:** Loads data into core data. Produces array of glucose items on selected day

* **Improvements:** Can be made to access data from a csv file

#### *addNotifications()*
* **Description:** Adds popups on to main graph immediately when activity are added

#### *settingPreferences()*
* **Description:** Registers settings bundle. Updates app when settings changed so the UI responds to preferences user selected. For example, user may rather have the basal rate turned off, and when they switch off that button, the basal rate would disappear from graph.

#### *setDay()*
* **Description:** When users swiping across and the chart lands on a certain day or the user picks a date from the picker field, the popups list would be fetched for that day. So users get correct past activities for selected day.

#### *updateViews()*
* **Description:** Removes current drawings and plots on the main graph, replots chart, adds events popups and updates sideviews.

* **Output:** Updated bifocal section

#### *createDatePicker()*
* **Description:** Creates a date picker field on top of bifocal display. Sets it to current date initially. Allows users to pick a date in the past. Chart updates according to date selected. Side views update as well.

#### *calcRanges()*
* **Description:** Finds a maximum, a minimum in a array as well as calculates an average value.

* **Parameters:** An array of Doubles: data in the array to be calculated 

* **Returns:** Passes results to side views. Side view redraws range bar accordingly.

#### *initChart()*
* **Description:** 
  * Chart is constructed using layers. 
  * Draws popups and attaches messages to them.
  * Dates changes accordingly with swipes and plots changes accordingly.
  * Changes of dates gets passed in to update chart. 


[[1]](https://www.niddk.nih.gov/health-information/diabetes/overview/preventing-problems/low-blood-glucose-hypoglycemia):"Hypoglycemia". National Institute of Diabetes and Digestive and Kidney Diseases. October 2008. Archived from the original on 1 July 2015. Retrieved 28 June 2015.