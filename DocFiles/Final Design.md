# Final Design

During the project many things many changes were made from the client design to the final one, the rationale for which is procided in Design Process. A descriptive overview of the final design is provided here, with images of final design, all four domains and the graph pictured directly below for context.

<p align="center">
 <img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/fooddomain.png" width="300" />
 <img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/exercisedomain.png" width="300" />
</p>
<p align="center">
 <img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/healthdomain.png" width="300" />
 <img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/advicedomain.png" width="300" />
</p>
  
### Architecture

Exactly as in the client design the app consists of 4 main sections which overlap and can be brought to the front with only one click, as well as a bi-focal display to show blood glucose level. There is also a settings button in the top left which will redirect the user to the iOS settings menu for customisation. 

### Insulin

At the top right of the screen is an insulin button which if clicked will allow the user to enter how many doses of insulin they took and at what time.

### Food
* **Meal Entry** – The user can enter the name, time and amount of carbs, fat and protein of each meal they have in the day. The name entry is done via a normal keypad, the nutritional information entry is done via a number pad and the time entry is done via a drop-down picker view. When you click on the field and the keyboard appears, the entire box moves up the screen to stop the field from being obscured. 
* **Food Daily Log** – all entered meals appear in the log and clicking on any cell lets them expand to reveal the amount of carbs, protein and fat in the meal and an edit button which lets you change the information.
* **Favouriting System** – Meals can be added to favourites by highlighting the star on their row. Clicking on the star in the top right of the section changes the food daily log list to a list of favourited meals and clicking on any of these will auto-fill the meal entry fields so the user can change the time and nutritional information as necessary and then click add to add the meal as normal.

### Exercise
The exercise section works identically to the food one, with the ability to enter, view and favourite exercise activities. To enter an exercise activity the user needs to enter it’s name (via a keypad), time (via a drop down picker), intensity (select low, medium, high from a drop down picker) and it’s duration (also from a drop down picker).

### Health
*	**Tag Switches** – The health section contains a stress and an unwell switch which the user can turn on to tag that they were under unusual stress or ill on that day. This can be used either just allow users to keep track of how certain things effect their condition, or possibly factored in by the algorithm in the future.
* **Previous Days Log** – The health section contains a list of the previous 7, 30 or 60 days at the user’s discretion. Each row contains the date and a series of 5 symbols (hyper, hypo, exercise, stress and illness) which are highlighted green if a day contained that event. Clicking on a row makes it expand to also show the minimum, maximum and average blood glucose level for that day and a link to that day which if pressed will change all the domains and the graph to contain the data for that day.
* **Tag Filters** – you can select any of hyper, hypo, exercise, stress and illness to make the list only show the days from within the specified period which contain these tags.
* **Favouriting System** - Days can be favourited so you can more easily show your doctor any unusual or significant days.

### Advice
It is worth noting that at this stage the advice section is largely cosmetic and a lot of the features don’t actually work yet. This is because of a lot of these ideas came out in the focus group at the end of the project so there wasn’t time to implement them, and it would be difficult to do so anyway without much data to work with.
* **Trendspotter** – Identifies patterns, for instance ‘Hypos are most common on Wednesday morning’ which the user’s may be able to attribute to something in their behaviour not used by the app and modify their behaviour accordingly. Clicking on the plus button gives you a recommended solution, for instance ‘eat a larger breakfast’. These notifications can be dismissed if the user wants.
*	**Statistical Summaries** – The advice section will also contain a series of plots (for instance average blood glucose level for each day of the week) which can be swiped through or expanded into a pop-up so the user can see it in more detail.

### The Bi-focal Graph
*	**The Main Face** – Plots one day’s worth of blood glucose against time. A blue line indicates recorded levels and a dotted red line indicates predicted levels.
* **Bi-Focal Sidebars** – Each side bar represents one day in the past and the maximum, minimum and average blood glucose levels for that day are shown. If you swipe backwards in time ‘future’ side bars appear on the other side for days after the one currently on the main face. As you swipe through days, the food and exercise logs also change to show the activities from the day the graph is on.
*	**Current Blood Glucose Level** – The current blood glucose level is shown in a large font on the graph along with an arrow showing its trajectory (e.g. gently decreasing).
* **Activity Indicators** – The green, orange and blue dots on the graph represent insulin, food and exercise activities respectively and clicking on them creates a small pop-up with details about that activity.

### Status Indicators
* **Food** – The total number of grams of carbs, protein and fat consumed that day
* **Exercise** – The time until the next exercise activity
* **Health** – The users current heart rate (to be taken from the sensors once fully integrated)
* **Advice** – The number of notifications available.
