---

### `ViewControllerFood`
Controlls all UI elements in the open food domain

<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/fooddomain.png" alt="Image of food domain" width="400" />
</p>
<p align="center">
Image of open food domain
</p>

### `IndicatorControllerFood`
Controlls status indicators shown when food domain is hidden

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
* Carbs, Protein, Fat: 
<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/keypad.png" alt="Image of numpad" width="200"/>
</p>
<p align="center">
Image of numpad
</p>
    * Numpad pops up when tapped to allow the user to enter numbers. No decimal point is available on the numpad to provide safety to inputs. Input value is presumed to be in grams, as the logical unit of macro-nutrients typical in other apps, pumps and labels. 
```swift
        carbs: Int32((Double(carbsTextField.text!)?.rounded())!),
```
<p align="center">
Code for assignment of text field value for carbs
</p>
    * If a user uses an external keyboard and enters a decimal e.g. 5.5 this will be rounded to nearest integer
    * If a user uses an external keyboard and enters a value that cannot be rounded or converted to an int32 e.g. "jkl", the app will crash but will not add this to the log, so the database will not be corrupted and the user can reopen and continue to use the app. This is very unlikely to occur anyway.
* Add button: Only calls function to add new log to database if all fields contain some text.

### Table


### Favouriting System

### Status Indicators
