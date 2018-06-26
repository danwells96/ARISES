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
* Weekly meetings

**To Action (for next meeting):**
* Get access to Macs from IT
* Start learning the swift programming language
* Create a rough project timeline and plan
* Come up with specific design ideas to implement the requirements

### 04/05/18 - Meeting 2

**Actioned:** 
* Project timeline and plan produced 
* Some specific designs for domains created. 

**Discussion:**
* Bottom Half
  * Food/Exercise: Discussed whether we need a record of entered meals/exercise and how they would be entered in the first place, i.e. using text fields, selection from a series of pictures or in a pop-up. 
* Top Half (bi-focal display): 
  * Bifocal side bars should show dots indicating minimum, maximum and average blood glucose level for that day.  
  * Discussed whether separating things into breakfast, lunch and dinner on both the graph and in the food domain was a good idea given people don't necessarily have regular eating habits.  

**Decisions:** 
* No need to separate based on breakfast, lunch and dinner. 
* Food/exercise to be entered without requiring a pop-up to minimise clicks. 

**To Action:**
* Create the bubbles for the domain and make them come to the front if clicked on. 
* The client to provide us with sample data to use in the bifocal display. 
* Research how to create a bi-focal graph. 

### 09/05/18 - Meeting 3

**Actioned:**
* Basic floating bubbles created 
* Progress made towards bifocal display 

**Discussion:** 
* Whether floating bubbles or more conventual tab navigational system would be better. Advantages of tab system include user familiarity, more space being available for content in each window and a standard library of features to make coding easier. Advantages of floating bubbles include the ability to put status indicators in the corner, innovation and reduction in cognitive load for user. 
* How should data be entered to meals and exercise. 
* Favourites inc carousel

**Decisions:** 
* To create two prototype apps, one using tabs and the other using floating bubbles. 
* Wherever possible data entry should happen via picker menus (e.g. for times and duration). 

**To Action:** 
* Create two different app layouts to compare 
* Add stand in text fields, buttons and tables to the different domains 
* Have the bi-focal graph plot data and start working on sidebands

### 16/05/18 - Meeting 4

**Actioned:**  
* Both Tabs and Floating bubbles concepts produced 
* All four sections filled with placeholder content
* Basic graph with skewed (but not functional) sidebands produced and demonstrated 

**Discussion:** 
* Navigation functionality and user experience of both layouts
* Aesthetics, e.g. colour scheme
* How to input insulin doses
* How to display temporary basal rates (a continuous insulin injection supplied by a pump used by some diabetics)
* How information should be entered (e.g. sliders, keyboard or picker)

**Decisions:** 
* Standard IOS tabs concept rejected by client based on months of investment the team hadn’t been briefed on 
* Mac will be made available to use in Bob’s office 
* Colour scheme will avoid colours difficult for colour-blind users (e.g. red) since this is a common symptom of diabetes
* In-depth user experience will be delayed in favour of progress of functionality 
* Exercise will be moved to top right to allow keyboard space 
* Insulin input/information will be on graph not bottom section
* Decided against using sliders due to requiring a maximum value and difficulties with hitting values precisely. Use pickers or keyboards instead
* A focus group will be scheduled in June 

**To Action:**
* Create working time, duration and intensity pickers to allow meal and exercise entry
* Work on then displaying this information in a table
* Have the sidebands displaying low, average and high blood glucose levels on the bi-focal display

### 23/05/18 – Meeting 5 

**Actioned:** 
* Top and bottom half of the app merged to create a framework for the finished project
* The chosen 'floating bubbles' concept seperated out into a network of several connected views to speed up development in the long run
* The sidebands show the correct data (although are still not correctly skewed)
* Entered meals and exercise are displayed in their respective tables

**Discussion:**
*DOTS
*ANIMATIONS (value smoothness)
*How to favourite things
* The contents of the advice section
* How to add from favourites

**Decisions:** 

**To action:**
* Create a persistent storage relational database in which the meal and exercise information is stored
* Create and connect save and fetch functions to this database
* Fix the graph skew
* Add swiping animations to the graph
* Add animations to bringing sections to the fore
*Allow swiping through days


30/05/18 - Meeting 6

**Actioned:**
* Graph skew fixed
* Meals and exercise can be stored and added from favourites using persistent storage
* Entering meals and exercise create dots on the bi-focal display which if clicked on produce a pop-up detailing information about that event
* Glucose data on graph stored in and accessed from core data
* Tags
* Swipe through days

**Discussion:** 
* Animations not posible
* Swiping through status indicators
* How to add insulin

**Decisions:** 

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
* Change food days log
* Health days log day filters
* cosmetics for advice section

**Discussion:** 
* Handover
* Colour scheme
* Independent insulin adding

**Decisions:**
* documentation shoudl be sufficient for future work section etc., meet up to do a code review

