# Testing

The following test protocol was used to check that everything worked as expected on the user end.

<details><summary>Show Test Protocol</summary>
<p>

Checking: Insulin Entry
Method: Type in an insulin dose and a time
result: green dot appears on the graph clicking on this dot yeilds a pop-up containing the number of units.<br/>

Checking: Working Settings
Method: Click on the settings button and then toggle the switch entitled 'Basal rate'. Return to the app to observe the result
Result: Redirects you to an iOS settings menu containing a switch entitled 'basal rate'. After toggling this, the presence of the grey line on the graph will toggle

Checking: Data plotting
Method: Since there is no real data present yet this is just testing that some plotting mechanism is working so simply look at the graph to observe the line
Result: A blue line which at some point becomes a dotted red line to indicate prediction. It is worth noting that at this stage the prediction line takes over at an arbitrary point instead of the current time.

Checking: Bi-focal Time travel
Method: Firstly, to check that it works trivially swipe back to the previous few days and confirm that the graph on the bi-focal, the food list and the exercise lists all change. To check it works properly take a screenshot of the app on one day and then on the next swipe back to that day and confirm that the lists and graph contain the actual correct information from this day.
Result: The graph should change to show previous day's data and the food and exercise logs should change to show previous day's activities.

Checking: Date Selection
Method: Click on the date above the bi-focal display 

Checking: Food Entry (from scratch)
Method: Enter a food name, time and amount of carbs, protein and fat and click add. Then Click on the it's cell to expand it and click on the newly appeared orange dot on the bi-focal display
Result: The food should appear in the log with all information the same as what you entered. Clicking on the orange dot should produce a pop-up with accurate information in it.

Checking: Exercise Tag
Method: Assuming no exercise has been added for today so far go into the health domain and find today's date in the log to confirm that the exercise icon is grey
Result: The exercise icon should be grey

Checking: Exercise Entry (from scratch)
Method: Follow the same process as for food, but in the exercise domain and clikcing on the blue dot on the bi-focal instead of the orange. There is also no need to try and click to expand the cell. Go into the health domain again and find today's date.
Result: The same result as for food but for the new information entered. Confirm that today's exercise icon has turned green in the health domain.

Checking: Adding Food to Favourites
Method: Click on the star next to any meal in the food log such that it highlights orange. Then click on the orange star above the add button in the top right corner.
Result: The meal you starred is now in the list

Checking: Removing Food from Favourites
Method: Click on a star such that it turns grey. Then click on the orange star above the add button in the top right corner
Result: This meal is no longer in the list.

Checking: Adding and Removing Exercise from Favourites
Method: Do the same thing as for food but in the exercise section
Result: The same as for food.

Checking: Food Entry (from favourites)
Method: Go to the favourites list by clicking on the orange star above the add button. Click on any of the meals. Click the add button as if you were entering a normal meal.
Result: When clicked upon the fields at the top should have been auto-filled with the information about that meal. When add is clicked that meal should join the food daily log.

Checking: Exercise Entry (from favourites)
Method: The same as food entry from favourites but in the exercise domain.
Result: The same as food entry from favourites but in the exercise domain.

Checking: Tag switches
Method: Go into the health domain and if the are 'on' (i.e. green) turn them off and wait until tomorrow to test this feature. If they are off scroll down to today's date in the log of days and confirm that the stress and illness indicators are grey for today. Turn the switches on and off again (off again for ease of future testing). Scroll down to find today's date in the log and see if the stress and illness symbols are highlighted green.
Result: The stress and illness symbols for today are green when previously they were grey

Checking: Hypo/hyper detection
Method: Scroll to a day on the bifocal where a hyper occured (i.e. the blue line goes above 10 and into the top peach zone) and then look at that day in the days log in the health section. Do the same to find a day where a hypo occured (blue line goes below 4 and into the bottom peach zone) and check in the health section. It may be worth repeating this process with multiple days.
Result: The down arrow will be highlighted green to indicate a hypo and the up arrow to indicate a hyper, so on days where you've identified either of these things happening the relevant arrow should be green.

Checking: 60 Days in list
Method: Click on the 60 Days button and scroll to the oldest date in the list
Result: The oldest date should be 60 days ago, however, currently there aren't 60 days worth of data as the project is younger than that so just confirm that there are more days than in the 30 days section for now.

Checking: 30 and 7 Days in List
Method: Now click on the 30 days and 7 days buttons
Result: Confirm that the oldest dates were 30 and 7 days ago respectively.

Checking: Tag filters
Method: Click on each of the tag filters (e.g. hypo) in turn and then try every combination of filters
Result: Every row should have the selected tag filters corresponding icon green

Checking: Links to days
Method: Click on a row in the days log in the health section to expand it. Then click on the view button. Repeat the process with multiple days to thoroughly confirm correct operation.
Result: The date at the top of the bi-focal display should be the same as the date you clicked on in health

Checking: Favouriting days
Method: Still in the days log in the health section, click on the star next to any of the rows (it should turn green) to add it to favourites. Then click on the green star in the top right to bring up the list of favourites to confirm it is present. Then click on the view button and perform the links to days test described above. Test with multiple days for confirmation.
Result: The day will now be present in the favourites list and clicking on the view button should yield the result described in the links to days test.

Checking: Expanding Advice
Method: Go into the advice section and click on the plus arrow next to the advice suggestion provided
Result: A second row should appear with the text 'try eating a larger breakfast'

</p>
</details>


Internal Workings:

Edge cases:

