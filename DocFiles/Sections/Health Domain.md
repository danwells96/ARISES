---

### `ViewControllerHealth`
Controls all UI elements in the open health domain

<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/healthdomain.png" alt="Image of healthdomain" width="400"/>
</p>
<p align="center">
Image of open health domain
</p>


## Features
* Switches to track illness and stress
* Filterable table showing summary information about previous days
* Favouriting system to save and view previous day logs

### Illness and Stress switches
*   When turned on, stores start date. When turned off, adds start and end date to an illness/stress log. This allows duration to be calculated as a computed property of `Illness` and `Stress`.

### Table
* Setting cell labels: `ViewControllerHealth.tableView(_:cellForRowAt:)` uses fetched objects to set the labels of the table's cells
<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/healthcell.png" alt="Image of health table cell" width="200"/>
</p>
<p align="center">
Image of Health table cell
</p>
* Expanding table cells: When a cell is selected it will expand or contract to show/hide the low/avg/high of that day's glucose logs
* Displaying summaries of previous day's information: Previous `Day` logs are fetched, then filtered based on user's selected filters, such as whether the user had a hypoglycaemic glucose value on that day and the number of previous days to show. Icons highlighted green display whether that day contained a Hypo, Hyper, Exercise log, Stress or Illness.
<p align="center">
<img src="https://raw.githubusercontent.com/danwells96/ARISES/master/DocFiles/img/healthicons.png" alt="Image of health summary icons" width="200"/>
</p>
<p align="center">
Summary icons from left to right: Hypo, Hyper, Exercise, Stress and Illness
</p>
* View button: Optional function `tableCellDelegate.didPressViewDayButton(_:)` allows a button in the cell to post a notification that `ViewControllerGraph` picks up using an observer, to display that `Day` on the graph.

```swift 
func didPressViewDayButton(_ tag: Int) {
    let nc = NotificationCenter.default
    nc.post(name: Notification.Name("setDay"), object: (loggedDays[tag].date)!)
}
```
<p align="center">
Image of code in ViewControllerHealth to allow cell 'view' buttons to change day displayed on graph
</p>

### Favouriting System
* Favouriting: If a user clicks the star of a day cell it will highlight in the colour of the domain to symbolise it has been favourited. This will call a function to add the `Day` to the favourites object's relationships. 
* Choosing from favourites: When the star in the data entry section is selected, it will highlight in the colour of the domain. The table will update to display `Day`' logs which are favourited instead of the previous day summaries. The user can use the view button to display it on the graph.

## Future Work
* Add status indicators to show summary information for that day or other useful information
* Add customisable filters and tags to `Day` logs
