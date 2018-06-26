---

### `ViewControllerFood`
Controls all UI elements in the open food domain

<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/fooddomain.png" alt="Image of food domain" width="400" />
</p>
<p align="center">
Image of open food domain
</p>

### `IndicatorControllerFood`
Controls status indicators shown when food domain is hidden

<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/foodindicator.png" alt="Image of food domain status indicators"/>
</p>
<p align="center">
Image of food domain status indicators
</p>

## Features
* Data entry fields for adding information about meals
* Table showing information about meals for the displayed day 
* Favouriting system to save and choose from favourited meals
* Status indicator to show important information when other domains are being viewed

### Data Entry
* Name Text field: Keyboard pops up when tapped and the user presses Done when finished
* Time: Time Picker pops up to allow the user to choose a time. Dismissed when user presses Done.
<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/Time%20Picker.png" alt="Image of Time Picker" width="200"/>
</p>
<p align="center">
Image of Time Picker
</p>
* Carbs, Protein, Fat: 
Numpad pops up when tapped to allow the user to enter numbers. 
<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/keypad.png" alt="Image of numpad" width="200"/>
</p>
<p align="center">
Image of numpad
</p>
No decimal point is available on the numpad to provide safety to inputs. Input value is presumed to be in grams, as the logical unit of macro-nutrients typical in other apps, pumps and labels. </br>

    
````swift
    carbs: Int32((Double(carbsTextField.text!)?.rounded())!),
````
<p align="center">
    Code for assignment of text field value for carbs
</p> 

If a user uses an external keyboard and enters a decimal e.g. 5.5 this will be rounded to nearest integer.  </br>
If a user uses an external keyboard and enters a value that cannot be rounded or converted to an int32 e.g. "jkl", the app will crash but will not add this to the log, so the database will not be corrupted and the user can reopen and continue to use the app. This is very unlikely to occur anyway.
* Add button: Only calls function to add new log to database if all fields contain some text.
* Disabled for past days: Data entry fields are hidden if the user is not viewing the current day on the graph. 
* Moving view to prevent keyboard/picker obscuring field: An observer in ViewDidLoad allows the controller to tell when a keyboard/picker is open, and calls a function to move the view 65px upwards, to prevent the input field from being obscured.

````swift
let nc = NotificationCenter.default
//Observers to determine keyboard state and move view so that fields aren't obscured
nc.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
nc.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
````

### Table
* Setting cell labels: `ViewControllerFood.tableView(_:cellForRowAt:)` uses fetched objects to set the labels of the cells
<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/foodcell.png" alt="Image of food table cell" width="200"/>
</p>
<p align="center">
Image of Food table cell
</p>
* Expanding table cells: When a cell is selected it will expand or contract to show/hide the macro-nutrients of that meal
* Displaying meal logs for current day shown on graph: An observer is used to watch for notifications from `ViewControllerGraph` and update the class' `currentDay` property. The data for the table is then fetched again for meal logs which match `currentDay`  

````swift 
let nc = NotificationCenter.default
//Observer to update currentDay variable to match graph's day
nc.addObserver(self, selector: #selector(updateDay(notification:)), name: Notification.Name("dayChanged"), object: nil)
````
<p align="center">
Instantiation of observer for when day displayed on the graph changes
</p>

### Favouriting System
* Favouriting: If a user clicks the star of a meals cell it will highlight in the colour of the domain to symbolise it has been favourited. This will call a function to add the meal to the favourites object's relationships. 
* Choosing from favourites: When the star in the data entry section is selected, it will highlight in the colour of the domain. The table will update to display meals which are favourited instead of the current day's meals. If a user selects one of these cells, it will automatically fill in the text fields with that meal's macro-nutrients and the current time. The user can then adjust or add this meal as normal.

### Status Indicators
* Displaying information: `IndicatorControllerFood` contains a viewDidLoad override to set the value of the labels to the total carbs, protein and fat for the day shown. These values are available as a computed property in the `Day` category/extension file.  
* Updating: Similarly to the table, an observer is used to track the currently displayed day on the graph. A second observer is used to update the values when a new meal is added to the current day.

```swift
let nc = NotificationCenter.default
//Observer to update indicators when new meal added
nc.addObserver(self, selector: #selector(foodStatsUpdated), name: Notification.Name("FoodAdded"), object: nil)
```
<p align="center">
Instantiation of observer for updating indicator when new meal is added
</p>

## Future Work
* Add buttons to edit or remove a meal log from the databse in the table.

