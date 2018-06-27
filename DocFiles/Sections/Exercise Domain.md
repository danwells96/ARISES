---

### `ViewControllerExercise`
Controls all UI elements in the open exercise domain

<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/exercisedomain.png" alt="Image of exercise domain" width="400"/>
</p>
<p align="center">
Image of open exercise domain
</p>


## Features
* Data entry fields for adding information about exercise
* Table showing information about exercise for the displayed day 
* Favouriting system to save and choose from favourited exercise activities

### Data Entry
* Name Text field: Keyboard pops up when tapped and the user presses 'Done' when finished
* Time: Time Picker pops up to allow the user to choose a time. Dismissed when user presses 'Done'.
<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/Time%20Picker.png" alt="Image of Time Picker" width="200"/>
</p>
<p align="center">
Image of Time Picker
</p>
* Intensity: A View Picker pops up to allow the user to choose an intensity. This is dismissed when user presses 'Done'.
<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/intensitypicker.png" alt="Image of View Picker" width="200"/>
</p>
<p align="center">
Image of View Picker
</p>
* Duration: A View Picker pops up to allow the user to choose a duration for their exercise. Dismissed when user presses 'Done'.
<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/durationpicker.png" alt="Image of Duration Picker" width="200"/>
</p>
<p align="center">
Image of Duration Picker
</p>
* Moving view to prevent keyboard/picker obscuring a field: An observer in ViewDidLoad allows the controller to tell when a keyboard/picker is open and calls a function to move the view 65px upwards, to prevent the input field from being obscured.

````swift
let nc = NotificationCenter.default
//Observers to determine keyboard state and move view so that fields aren't obscured
nc.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
nc.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
````


### Table
* Setting cell labels: `ViewControllerExercise.tableView(_:cellForRowAt:)` uses fetched objects to set the labels of the table cells
<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/exercisecell.png" alt="Image of exercise table cell" width="200"/>
</p>
<p align="center">
Image of Exercise table cell
</p>
* Displaying exercise logs for current day shown on graph: An observer is used to watch for notifications from `ViewControllerGraph` and update the class' `currentDay` property. The data for the table is then fetched again for exercise logs which match `currentDay`  

````swift 
//Observer to update currentDay variable to match graph's day
nc.addObserver(self, selector: #selector(updateDay(notification:)), name: Notification.Name("dayChanged"), object: nil)
````
<p align="center">
Instantiation of observer for when day displayed on the graph changes
</p>


### Favouriting System
* Favouriting: If a user clicks the star of an exercise log's cell it will highlight in the colour of the domain, to symbolise it has been favourited. This will call a function to add the exercise to the `Favourites` object's relationships. 
* Choosing from favourites: When the star in the data entry section is selected, it will highlight in the colour of the domain. The table will update to display exercise logs which are favourited instead of the displayed day's exercise logs. If a user selects one of these cells, it will automatically fill in the text fields with that exercise log's information and the current time. The user can then adjust or add this exercise, as normal.


## Future Work
* Add status indicators to show next planned exercise or other useful information.
* Add expanding cells and buttons to edit or remove an exercise log from the database in the table.
