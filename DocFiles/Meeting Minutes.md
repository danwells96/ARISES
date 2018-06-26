# Meeting Minutes

### 01/05/18 – Meeting 1  

**Discussion:**
* Given basic design requirements 
  * No hierarchy - all content accessible on one page 
  * All key information visible at all times 
  * 'Bi-focal display' of one day's glucose levels, summaries of previous day's information and important info highlighted e.g. meals, hypos, exercist activites...
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

### 04/05/18 - Meeting 2

**Actioned:** 
* Project timeline and plan produced 
* Mockup designs of an interpretation of the requirements spec created

**Discussion:**
* Bottom Half
  * Food/Exercise: Discussed whether we need a record of entered meals/exercise and how they would be entered in the first place, i.e. using text fields, selection from a series of pictures or in a pop-up
* Top Half (bi-focal display): 
  * Bifocal side bars should show dots indicating minimum, maximum and average blood glucose level for that day  
  * Discussed whether separating things into breakfast, lunch and dinner on both the graph and in the food domain (as in the client design) was a good idea given people don't necessarily have regular eating habits
* Should the architecture be a series of overlapping bubbles with no home state (as in the client design) or four squares which can be maximised and minimised

**Decisions:** 
* No need to separate based on breakfast, lunch and dinner
* Food/exercise to be entered without requiring a pop-up or expansion to minimise clicks
* A log of entered food and exercise is crucial
* To split development team into two groups: Rebecca and Ryan to work on bottom half, Dan and Xiaoyu to work on bi-focal display
* Decided to go for the 'overlapping bubbles' architecture for reasons of aesthetic and click minimisation
* The client to provide us with sample data to use in the bifocal display

**To Action:**
* Create the bubbles for the domain and make them come to the front if clicked on
* Familiarise ourselves with the XCode software and continue to learn swift
* Research how to create a bi-focal graph

### 09/05/18 - Meeting 3

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
* Have the bi-focal graph plot data and start working on sidebands

### 16/05/18 - Meeting 4

**Actioned:**  
* Both tabs and floating bubbles concepts produced 
* All four sections filled with placeholder content
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
* Insulin input/information will be on the graph instead of within the health section
* Decided against using sliders for data input since they have to be capped at a certain value and it is difficult to hit values precisely. Pickers, keypads and numpads to be used instead.
* A focus group will be scheduled in June 

**To Action:**
* Create time, duration and intensity pickers to allow meal and exercise entry
* Work on then displaying this information in a table
* Have the sidebands displaying low, average and high blood glucose levels on the bi-focal display

### 23/05/18 – Meeting 5 

**Actioned:** 
* Top and bottom half of the app merged to create a framework for the finished project
* The chosen 'floating bubbles' concept seperated out into a network of several connected views to speed up development in the long run
* The sidebands show the correct data (although are still not correctly skewed)
* Entered meals and exercise are displayed in their respective tables

**Discussion:**
* Should the user be able to see something like icons or lines to represent food and exercise on the bi-focal display so they can put information in context
* What sorts of animations should be added to various actions within the app to create a more fluid user experience
* How meals should be chosen from favourites
* How meals should be added from favourites
* What should the layout of the advice section look like

**Decisions:** 
* Dots should be used to represent meals and exercise on the bi-focal display
* Research into animations should be prioritised
* The star system was created where a meal is added/removed from favourites by selecting/deselecting the star on its row and then clicking on the star in the top right replaces a food log with a list of favourite meals. These meals can then be added to the daily log by clicking on them.

**To action:**
* Create a persistent storage relational database to store meal and exercise information
* Create and connect save and fetch functions to this database
* Fix the skew of the graph's sidebars
* Add animations on swiping through the days on the graph and bringing sections to the fore.
* Implement the favourites system described above

30/05/18 - Meeting 6

**Actioned:**
* Skew on the graph's sidebars fixed
* Meals and exercise can be stored and added from favourites using persistent storage and the star method discussed at the previous meeting
* Entering meals and exercise to the logs causes corresponding dots to appear at the right time on the bi-focal display
* Clicking on the dots triggers a pop-up with information about that event
* Glucose data on graph stored in and accessed from core data
* The stress and illness tags in the health section are now stored as entities in core data and turning them on and off records start and end time and based on that works out which days they were active for
* Days can be swiped through on the bi-focal as detailed in the requirements spec, and when in previous days today's information turns into a summary on the future bands
* Three different animation options were created for the bottom sections, but none of them look very good

**Discussion:** 
* Whether any of the tested animation options for bringing tiles to the fore were acceptable
* What the status indicators should contain 
* How insulin should be added - should it be added in the food section as it is normally taken with meals
* It may be technically infeasable within the time frame to make it able to take photos of meals since this feature can only be tested on an actual phone (rather than the standard simulation), so this is a more time consuming and difficult process
* How the user can check whether the nutritional information
* health section

**Decisions:** 
* Deprioritse taking photos
* The animations would be shown to the focus group and they would be asked their opinion
*Status swiping since too many ideas
*edit using expansion

**To action:**
* Get status indicators working
* Get health days log working
* Expanding cells
* Health filters working

06/06/18 - Meeting 7 (Focus group)

**Actioned:**
* Food status indicator working
* Health filters
* Expanding cells

/////////////////link to minutes

13/06/18 - Meeting 8

**Actioned:** 
* Settings
* Insulin
* Dots for insulin
* Change food days log on swipe
* Health days log day filters
* cosmetics for advice section
* Sections move up to make room for keyboard
* Food dots moves up
*Auto fil from favourites

**Discussion:** 
* Handover
* Colour scheme
* Independent insulin adding

**Decisions:**
* documentation shoudl be sufficient for future work section etc., meet up to do a code review

