---

### `ModelController`
Provides fuctions to safely add and fetch objects from the persistent relational database in ‘Core Data’

<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/database.png" alt="Image of relational database graph"/>
</p>
<p align="center">
Image of relational database graph ARISES.xcdatamodeld
</p>

### `PersistenceService`
Initialises a persistent store and provides functions to allow ModelController to add objects to it’s context and save that context.

### `Category/Extension files`
One file for each NSManagedObject E.g. `Glucose`. Allows computed properties and methods to be added to objects in the database to extend their functionality, while automatically generating base property declarations from information added to the `ARISES.xcdatamodeld` relational database chart. 


## Features
* Adding logs to relational database
* Persistent storage of database logs
* Fetching of filtered and sorted arrays of objects 
* Extending objects with computed properties to access key information easier


### Adding to database
* `ModelController` adds functions that search for existing objects with known links to the object to be added, then adds the new object as a relationship. E.g. When a new `Meals` object is added, the function searches for a `Day` log with a matching day component of their dates, and adds the meals to that day's meals relationship. If no matching `Day` log is found, one is created with the new date's day component.
* When objects are added to the database, they often post notifications, so that `ViewControllerGraph` or other classes can observe them and update their views accordingly.

````swift
let nc = NotificationCenter.default
nc.post(name: Notification.Name("FoodAdded"), object: nil)
````
<p align="center">
Code for notification posted when food is added to database
</p>


### Persistent storage
* `PersistenceService` adds functions that allow `ModelController` to find a shared context, make changes to objects within that context and then save it so that is persists on the device.

### Fetching objects
* `ModelController` adds functions to fetch arrays of objects, primarily for use in creating tables of information. These arrays are filtered, and sorted in a logical order, depending on their contents. E.g. `Meals` in ascending time, Favourite meals in alphabetical order.

### Extensions of objects
* Many category/extension files contain computed properties which provide easy access to a summary of information. These properties are used in many places. E.g. `Day.foodStats` which returns a tuple containing the total carbs, protein and fat for that day, which is used to create the food domain status indicator. 
* The duration property visible in `Illness`, `Stress` and `Day` is working, but currently unused within the app

## Future Work
* Functions for removing/editting logs to incorporate with future edit button functionality
* Potentially refactor using generic types to reduce boilerplate code
* Adjust to work as a framework for use with continuous blood glucose monitor and activity band

