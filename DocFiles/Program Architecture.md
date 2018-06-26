# Program Architecture
* The following document gives an overview of the high-level architecture of the app, the interactions between and some justifications for these choices.
* While Swift supports other programming archetypes, such as function or protocol oriented programming, the majority of this app is UI based so Object-Oriented programming used. Due to limitations on project time and developer knowledge, the architecture likely does not follow strict MVC (Model View Controller) architecture, borrowing some concepts from MVVM due to the database model being shared between all classes.

## Storyboard
* What is the storyboard?
<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/storyboard.png" alt="Image of app storyboard"/>
</p>
<p align="center">
Image of app storyboard
</p>

## Class responsibilities
* Why were they split?

### `ViewControllerMain`
Controls transitions between domains by showing and hiding domain and indicator views. Also controls insulin entry fields.

### `ViewControllerFood`
Controlls all UI elements in the open food domain

### `ViewControllerExercise`
Controlls all UI elements in the open food domain

### `ViewControllerHealth`
Controlls all UI elements in the open health domain

### `ViewControllerTableViewCell`
View Controller for Table Cells in all domains

### `ModelController`
Provides fuctions to safely add and fetch objects from the persistent relational database in ‘Core Data’

### `ViewControllerAdvice`
Controlls all UI elements in the open advice domain

### `ViewControllerGraph`


## Interactions
View Controllers communicate via 2 methods:
* Calling functions in other classes
* Observing notifications from other classes

<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/hierarchy.png" alt="Image of comunication between classes"/>
</p>
<p align="center">
Image showing communication between the main classes
</p>

### Calling functions in other classes
* What is it?
* Where is it used?
* Why?
### Radio/ Notifications
* What is it?
* Where is it used?
* Why?
