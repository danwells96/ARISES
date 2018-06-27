# Meeting Minutes

## Feature Implementation Date Record

Below is a list of all the features that were implemented during the project and the dates on which they were carried out, provided for future reference and in case of intellectual property disputes.
<details><summary> 
Show Feature Implementation Date Record
</summary>
<p>
</br>
07/05/18 - Design basic square expanding idea </br>
11/05/18 - Complete tabs and 'floating bubbles' prototypes</br>
14/05/18 - Fill placeholder content for all windows</br>
15/05/18 - Graph plotting data</br>
15/05/18 - Created time, duration and intensity pickers</br>
18/05/18 - Sidebands diaplying maximum, mean and minimum blood glucose levels</br>
21/05/18 - Top and Botton sections merged</br>
22/05/18 - Finished core data storage for food and displaying it in the table</br>
23/05/18 - Core data implemented for exercise</br>
24/05/18 - Ability to swipe through days on the graph</br>
24/05/18 - Final colour palette selected</br>
28/05/18 - Adding from and storing to favourites working</br>
28/05/18 - Favourite stars toggling correctly</br>
28/05/18 - Activity dots can appear on grap</br>
28/05/18 - Days list in health correctly displaying</br>
29/05/18 - Tags added to data model</br>
29/05/18 - Insulin and glucose added to the data model</br>
29/05/18 - Pop-ups appear when activity dots are tapped</br>
30/05/18 - Food status indicator (total carbs, protein and fat) created</br>
01/06/18 - Correct data attached in the pop-ups</br>
03/06/18 - Expandable table cells created</br>
04/06/18 - Prediction line created</br>
05/06/18 - Days list can be filtered by tags</br>
06/06/18 - Number of days in list can be chosen</br>
09/06/18 - Added meals now auto-fill the data entry fields instead of appearing straight away</br>
09/06/18 - Food and exercise domains move up with the keyboard is in use</br>
09/06/18 - Food dots are higher up the graph if they contain more carbs</br>
10/06/18 - Settings button created</br>
10/06/18 - Cosmetic mockup of advice section created</br>
11/06/18 - Can see previous days' food and exercise logs when on previous days' graphs</br>
12/06/18 - Insulin dose entry added</br>
12/06/18 - Entered insulin doses are added to the graph</br>
12/06/18 - Date selector for the bifocal display added</br>
</p>
</details>

## 01/05/18 – Meeting 1  
</br>
 **Discussion:**
* Given basic design requirements 
  * No hierarchy - all content accessible on one page 
  * All key information visible at all times 
  * 'Bifocal display' of one day's glucose levels, summaries of previous day's information and important info highlighted e.g. meals, hypos, exercist activites...
  * Ability to access summary data 
* Briefed on basic aims of the project
  * Demonstrate an app with a functional UI and as much of the outlined design as possible completed (not expected to fully finish within the time frame)
* Link to the full requirements spec and initial client design: [Client Design](https://danwells96.github.io/ARISES/client-design.html)

**Decisions:**
* Hold weekly meetings

**To Action (for next meeting):**
* Get access to Macs from IT
* Start learning the swift programming language
* Create a rough project timeline and plan
* Come up with specific design ideas to implement the requirements spec

## 04/05/18 - Meeting 2 
 </br>
**Actioned:** 
* Project timeline and plan produced 
* Mockup designs of an interpretation of the requirements spec created

**Discussion:**
* Bottom Half
  * Food/Exercise: Discussed whether we need a record of entered meals/exercise and how they would be entered in the first place, i.e. using text fields, selection from a series of pictures or in a pop-up
* Top Half (bifocal display): 
  * Bifocal side bars should show dots indicating minimum, maximum and average blood glucose level for that day  
  * Discussed whether separating things into breakfast, lunch and dinner on both the graph and in the food domain (as in the client design) was a good idea given people don't necessarily have regular eating habits
* Should the architecture be a series of overlapping bubbles with no home state (as in the client design) or four squares which can be maximised and minimised

**Decisions:** 
* No need to separate based on breakfast, lunch and dinner
* Food/exercise to be entered without requiring a pop-up or expansion to minimise clicks
* A log of entered food and exercise is crucial
* To split development team into two groups: Rebecca and Ryan to work on bottom half, Dan and Xiaoyu to work on bifocal display
* Decided to go for the 'overlapping bubbles' architecture for reasons of aesthetic and click minimisation
* The client to provide us with sample data to use in the bifocal display

**To Action:**
* Create the bubbles for the domain and make them come to the front if clicked on
* Familiarise ourselves with the XCode software and continue to learn swift
* Research how to create a bifocal graph
 
## 09/05/18 - Meeting 3
</br>
**Actioned:**
* Basic floating bubbles created 
* Progress made towards bifocal display 

**Discussion:** 
* Whether floating bubbles or more conventual tab navigational system would be better. Advantages of tab system include user familiarity, more space being available for content in each window and a standard library of features to make coding easier. Advantages of floating bubbles include the ability to put status indicators in the corner, innovation and reduction in cognitive load for user
* How data should be entered to meals and exercise
* There should be some way to have stored favourite meals to save time on meal entry. Discussed how this should work (i.e. should it store all meals, or only selected ones)
* Should a food carousel be used for meal selection, where the user takes pictures of their meals and clicking on a button makes these pictures fan out in a wheel and vanish when one is selected

**Decisions:** 
* To create two prototype apps, one using tabs and the other using floating bubbles for direct comparison
* Wherever possible data entry should happen via picker menus (e.g. for times and duration)

**To Action:** 
* Create two different app layouts to compare 
* Add stand in text fields, buttons and tables to the different domains 
* Have the bifocal graph plot data and start working on sidebands

## 16/05/18 - Meeting 4
</br>
**Actioned:**  
* Both tabs and floating bubbles concepts produced 
* All four domain filled with placeholder content
* Basic graph with skewed (but not functional) sidebands produced and demonstrated 

**Discussion:** 
* Which layout was more user friendly and allowed the most usable space
* Aesthetics, e.g. colour scheme
* How to input insulin doses - should it be assumed that the user follows the app's recommendation? Should insulin information be contained within the health sectoin
* How to display temporary basal rates (a continuous insulin injection supplied by a pump used by some diabetics)
* How information should be entered (e.g. sliders, keyboard or picker)

**Decisions:** 
* Original floating bubbles architecture chosen based on expert advice and prior investment into that concept
* Mac will be made available for use in Bob Spence's office 
* Colour scheme will avoid colours difficult for colour-blind users (e.g. red) since this is a common symptom of diabetes
* Exercise will be moved to top right to allow keyboard space 
* Insulin input/information will be on the graph instead of within the health domain
* Decided against using sliders for data input since they have to be capped at a certain value and it is difficult to hit values precisely. Pickers, keypads and numpads to be used instead.
* A focus group will be scheduled in June 

**To Action:**
* Create time, duration and intensity pickers to allow meal and exercise entry
* Work on then displaying this information in a table
* Have the sidebands displaying low, average and high blood glucose levels on the bifocal display

## 23/05/18 – Meeting 5 
</br>
**Actioned:** 
* Top and bottom half of the app merged to create a framework for the finished project
* The chosen 'floating bubbles' concept seperated out into a network of several connected views to speed up development in the long run
* The sidebands show the correct data (although are still not correctly skewed)
* Entered meals and exercise are displayed in their respective tables

**Discussion:**
* Should the user be able to see something like icons or lines to represent food and exercise on the bifocal display so they can put information in context
* What sorts of animations should be added to various actions within the app to create a more fluid user experience
* How meals should be chosen from favourites
* How meals should be added from favourites
* What should the layout of the advice domain look like

**Decisions:** 
* Dots should be used to represent meals and exercise on the bifocal display
* Research into animations should be prioritised
* The star system was created where a meal is added/removed from favourites by selecting/deselecting the star on its row and then clicking on the star in the top right replaces a food log with a list of favourite meals. These meals can then be added to the daily log by clicking on them.

**To action:**
* Create a persistent storage relational database to store meal and exercise information
* Create and connect save and fetch functions to this database
* Fix the skew of the graph's sidebars
* Add animations on swiping through the days on the graph and bringing domain to the fore.
* Implement the favourites system described above

## 30/05/18 - Meeting 6
</br>
**Actioned:**
* Skew on the graph's sidebars fixed
* Meals and exercise can be stored and added from favourites using persistent storage and the star method discussed at the previous meeting
* Entering meals and exercise to the logs causes corresponding dots to appear at the right time on the bifocal display
* Clicking on the dots triggers a pop-up with information about that event
* Glucose data on graph stored in and accessed from core data
* The stress and illness tags in the health domain are now stored as entities in core data and turning them on and off records start and end time and based on that works out which days they were active for
* Days can be swiped through on the bifocal as detailed in the requirements spec, and when in previous days today's information turns into a summary on the future bands
* Three different animation options were created for the bottom sections, but none of them look very good

**Discussion:** 
* Whether any of the tested animation options for bringing tiles to the fore were acceptable
* What the status indicators should contain 
* How insulin should be added - should it be added in the food domain as it is normally taken with meals
* It may be technically infeasable within the time frame to make it able to take photos of meals since this feature can only be tested on an actual phone (rather than the standard simulation), so this is a more time consuming and difficult process
* How the user can check whether the nutritional information they entered is accurate and change it if not
* Dsicussed how trends should be shown in the health domain

**Decisions:** 
* Deprioritse ability to take pictures of meals based on technical challenges
* The animations would be shown to the focus group and they would be asked their opinion
* Since there are many things to show on status indicators the user should be able to swipe through them
* Cells in the food domain should be able to expand when selected to reveal nutritional information and an edit button

**To action:**
* Get basic status indicators working
* Make cells in the food domain expand if selected
* Have a list of days accessable in the health domain which can be filtered down to a certain number of days and filtered based on tags

## 06/06/18 - Meeting 7 (Focus group)
</br>
**Actioned:**
* Status indicator for food working
* In the health domain the number of days shown in the table can be changed and they can be filtered based on tags
* Cells in the food domain expand to show nutritional information and in the health domain expand to show glucose information summaries and a view button, which if pressed takes you to that day on the bifocal display.
* A favouriting system is operational in the health domain.
* Added a line for temporary basal rate on the graph

Focus group minutes: [Focus Group Report](https://danwells96.github.io/ARISES/focus-group-report.html)

## 13/06/18 - Meeting 8
</br>
**Actioned:** 
* Created a settings button which redirects the user to the iOS settings menu. From here they can turn the temporary basal trace on and off
* Let the user enter insulin doses and the time they were taken
* These insulin doses appear as dots on the graph which can produce pop-ups much like with food and exercise 
* As the day's are swiped through on the bifocal the contents of the food and exercise logs changes to match the logs from those days
* The cosmetic design for the advice domain was created based on the focus group feedback to act as a placeholder for future work
* The food and exercise domains move up when the keyboard is in use to avoid text fields being obscured
* The food dots on the bifocal display are higher up the graph if they contain more carbs so the user can instantly identify them
* Instead of meals added from favourites appearing directly in the food log and the user having to edit them to adjust for time and portion size they now auto-fill the meal entry text to reduce the number of clicks needed to change the time
* The ability to select a date from a picker menu accessed by clicking on the large date at the top of the bifocal. Once selected you will be taken to that date

**Discussion:** 
* The logistics of handing the project over to a new team of developers
* Summary of progress made and future work required
* Colour scheme
* The benefits of the solution for adding insulin

**Decisions:**
* The documentation required by the project should be sufficient for a smooth handover
* We are to meet up with the team who will be continuing with this project after us to do a full code review



