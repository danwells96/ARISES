# Program Architecture
* The following document gives an overview of the high-level architecture of the app, the interactions between and some justifications for these choices.
* While Swift supports other programming archetypes, such as function or protocol oriented programming, the majority of this app is UI based so Object-Oriented programming used. Due to limitations on project time and developer knowledge, the architecture likely does not follow strict MVC (Model View Controller) architecture, borrowing some concepts from MVVM due to the database model being shared between all classes.

## Storyboard
* The storyboard is a feature of Xcode that allows developers to describe properties of UI elements and see them visually represented, without writing code. For this project this is primarily used to separate domains into different embedded views (shown by the grey lines) and layout UI elements. 

<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/storyboard.png" alt="Image of app storyboard"/>
</p>
<p align="center">
Image of app storyboard
</p>

## Class responsibilities
* As visible in the image above, the app is separated into subviews. This is done to allow much easier manipulation of UI elements within the storyboard, where they would otherwise overlap and be difficult to select and adjust.
* Each subview has a class which acts as a View Controller, providing the code to power its interactions. This also reduces the size of View Controller files and gives each a more specific purpose.  
* Some classes do not provide UI code, but act as a framework to interact with the model. For example, the `ModelController` interacts with the relational core database and provides functions that View Controllers can use to add/retreive objects.

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
### [Open Image](https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/hierarchy.png) 

### Calling functions in other classes
* What is it?
* Where is it used?
* Why?

### Radio/ Notifications
* What is it?
* Where is it used?
* Why?
