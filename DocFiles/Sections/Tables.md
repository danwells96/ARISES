---

### `ViewControllerTableViewCell`
View Controller for Table Cells in all domains

<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/foodcell.png" alt="Image of table cell for food domain"/>
</p>
<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/exercisecell.png" alt="Image of table cell for exercise domain"/>
</p>
<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/healthcell.png" alt="Image of table cell for health domain"/>
</p>
<p align="center">
Images of cells for food, exercise and health domain 
</p>

### `tableCellDelegate`
Table cell delegate for button actions

```swift
@objc protocol tableCellDelegate : class {
    ///Calls didPressButton in each ViewController with a table
    func didPressButton(_ tag: Int)
    ///Optional function for use in ViewControllerHealth, to set graph day to view from table.
    @objc optional func didPressViewDayButton(_ tag: Int)
}
```
<p align="center">
Table Cell Delegate code
</p>

## Features
* Displays important information for its respective domain 
* Delegate system to allow working buttons for favouriting and other cell functions

### Displaying information

### Cell button actions


