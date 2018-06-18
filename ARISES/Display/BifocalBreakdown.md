# Bifocal Display Breakdown

Bifocal display is where the most important infomation are displayed on the main graph while less relevant data is displayed on the side views. Scroll across x-axis would allow users to access detailed data on a selected date.

**As the image shown below:**

Only range bars are shown on the side indicating maxima, minima and average.  The monitored glucoses, popups (meals, exercises, insulin dosages) and prediciton (only if main graph is on today) are plotted on main graph.

![Image of Bifocal](Bifocal.png)


## Chart Base Setup

The entire bifocal consists of three parts: 
  * Leftside view containers
  * Main graph section
  * Rightside view containers

Each of the side view containers has three subviews of type CustomView (UIView) which are customized to show colours bands as a background. 
#### *ChartBGView.swift* and *CustomView.swift*
The same colour bands are used on the main chart as well thus *ChartBGView.swift* follows the same logic as the *CustomView.swift* in term of filling the background color bands. But *CustomView.swift* is also used to draw range bars on each sideview using calculated values for glucose values storing in core data on a day.

###### Bands calculations
The bands are calculated based on glucose level. If the total height of the Custom View is considered as an equivalent glucose level of 20 (mM/)L  then a 'safe' range for patients to stay in would be between 4 and 10. Above 10 would be classified as a hyper and below 4 would be seen as a hypo.

Therefore, the top half of chart would be in **high** range, the bottom 4/20 (20%) of chart would be in **low** range and 6/20 (~30%)section in the middle would be of normal. 

The high and low bands are coloured differently to draw users attention. Colour palette here is simple and can be modified. (Colour combinations particularly red & green are avoided as diabetes suffering from retinopathy have problems distinguishing between them.)

##### *drawMiddleBand()*
* **Description:**
This function draws a rectangle with orgin (0,0) - top left corner, and extends itself to the reqired height (30% of total height). After it draws/marks, it colours the marked area with selected color.
* **Returns:**
This would give the background of image below (without the range bars).

![Image of sideview](sideview.png)

Here's a code snippet that colors the middle section white:

        let middleRect = CGRect(
            origin: CGPoint(x: 0.0, y: bounds.height/2),
            size: CGSize(width: frame.width, height: frame.height * 0.3)
        )
        #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1).set()
        UIRectFill(middleRect)
    
##### *drawRangeBar()*
* **Description:**
This function is created to draw maximun and minimum dashes as well as the average circle on side views. 
It uses UIBezierPath() as a drawing tool. Both line width and stroke colour can be set using this method.
* **Parameter:**
It takes no parameters but the output of sorting the glucose array on certain day would gives maximum and minimum. The the difference between the height of maximum/minimum is with respect to glucose level of 20(mM/L) would be the stroke length of the range bar.
* **Returns:** An UIView with a drawn range bar
