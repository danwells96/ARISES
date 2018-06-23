# Design Process

There were many things that were changed from the original design, or ideas that were added during the process based on discussions in meetings, technical constraints or the focus group. The most import design changes and the rationale behind them are detailed below:

**1.	  Architecture**

Based on the requirement of having no navigational hierarchy some additional designs to the overlapping bubbles were devised.
      
The first one (pictured below) featured four tiles which started at equal sizes, but any can be clicked on to expand them and then        clicked again to reduce to the home state. The principal motivation behind this design was limitations in technical knowledge at the start of the project and ultimately it was decided that this design was inferior to the original one as it requires more clicks for the user to access information.

<p align="center">
	<img src="https://github.com/danwells96/ARISES/blob/master/DocFiles/img/squares%20version.png" alt="Squares version"/>
</p>
<p align="center">
	Initial interpretation of client design
</p>

The second design used the more conventional approach of using tabs and is shown below. The motivations behind this design were firstly user familiarity as tabs are used across many iOS apps and secondly it is a more efficient use of screen space, so all the sections can be larger. Ultimately, however, it was decided that the client’s design was better as it allows more space for the status indicators described in the previous section and the decrease in usable space by each domain was acceptable.

<p align="center">
	<img src="https://github.com/danwells96/ARISES/blob/master/DocFiles/img/tabs%20version.png" alt="Tabs image"/>
</p>
<p align="center">
	Interface prototype of tabs design
</p>

**2.	 Usage of non-active space**
    
There was then a question of what to do with the content on the tiles when not in use as if you could just see starts of information poking out behind it would be very ugly and visually confusing for the user. If the information moved around to make sure it was always fully or not at all in view this would likewise be visually confusing and unappealing. Consequently, it was decided that tiles not currently at the fore should have a solid fill colour.
   
There was then discussion on what to do with the status indicators when their tile was in front, as it would take a lot of useful space out of the app if it was there and would make finding a nice layout difficult. It was eventually decided that the status indicators should be hidden when the tile was in use, and both this and the other decision can be seen on the final design in figure 4.3.
    
**3.    Bi-focal Display**

The client’s initial design for the bi-focal had the side bars containing the full previous day’s graph but tilted so it appeared to be going off into the distance. The problem with this is that it looked incredibly cluttered and since blood glucose level goes up and down several times during a day it was difficult to get any useful contextual information from this. Consequently, it was decided early on in the process that the sidebars should show summary data (i.e. max, min and average).

There was also much discussion about whether continuous scrolling (i.e. you can see partial days) or discrete scrolling (only one entire day at a time on the main face) should be used. It would be useful for diabetics to see what would happen to their blood glucose overnight (technically the next day), but similarly it would be more easy to get lost while scrolling.  Ultimately it was decided that it is not too inconvenient to swipe a day into the future to see night time predictions, whereas continuous scrolling could get very confusing.
      
**4.    Settings Button**

The decision to include a settings button came about as a result of the focus group meeting where the attendees expressed a desire to customise the amount of technical information about dosage calculation and the tag switches. As previously mentioned the optimum design would be for it to use some sort of pop-up but this was not possible due to time constraints so a design where the button redirects you to the iOS settings menu was instead used. 
      
**5.    Insulin Entry**

The original ideas informally suggested by the client where for either the app to assume the user has taken the calculated amount or for the user to be able to input how much insulin they take as they enter meals (given that most insulin doses are taken with meals). At the focus group meeting it was clear that neither of these designs would be adequate since many diabetics take insulin a short time before their meals or outside of meal time and others would not trust the dosage recommendations necessarily so may take more or less. 
      
The final design of having insulin accessible in its own area at the top of screen circumvents the problems mentioned above and is justifiable due to it’s importance. While it does not have a log associated with it, the green dots on the graph let the user see detailed information about it.
      
**6.    Data Entry Methods**

There were also questions about the most user friendly way to input meals and exercise information. Especially with regards to the carbs, fat and protein information there was lots of discussion about whether to use a sliding scale (the client’s initial proposal) and a number pad. Eventually a number pad was chosen firstly because a slider would need a maximum value and secondly it would be difficult to get a high enough resolution with a large range of values, and users would struggle to get the right number.
      
Drop down picker menus were used for times and exercise intensity and duration since these have a discrete set of values they can take and it would not take too long on average to scroll to reach the desired value.
      
**7.    Favouriting System**

Since most people have a set of meals they eat regularly it was decided that the app needed to store meals and let the user add them from memory.
      
The first idea was to have the app store every meal ever entered, however this would become very confusing, since you would have, for instance, a pizza from every pizza place you’ve ever visited once, whereas it would be much more useful to just have the ones you visit regularly stored. Consequently, it was decided that users should be able to decide which meals should be stored as favourites using the star system described previously.
      
Originally to add a meal from favourites it would simply need to be clicked on in the favourites list, however, it was decided it was more hassle to then edit that if you had a smaller portion or ate it at a different time, so instead the current system of auto-filling the text fields was implemented.
      
**8.    Food Carousel**

Another way of selecting meals from favourites that was proposed by the client was to be able to take pictures of favourite meals and then the choose from favourites button would create a wheel of these images to appear and slowly fan out until the user selected the desired one. There are some problems with this idea in that it may be difficult to discern between similar looking meals and would take a lot of time to use. This being said time constraints and technical difficult were the main reasons this feature wasn’t implemented.
      
**9.    The Purpose of the Advice Section**

As mentioned in the client design section the original purpose of the advice/education section was to send the user links to interesting new research and advice, however the focus group attendees unanimously said this would not be a useful feature. Alternative uses for this section were discussed and it was ultimately decided that being alerted of trends the user might have missed would be useful. The inclusion of a dismiss button was something they thought was really important in case they found the advice unhelpful. 
      
The decision to include supporting trends charts was taken to provide data to support the claims and for the user to identify trends themselves.
      
**10.   Tag Switches**

The use of stress and illness tags was featured in the client design, however the focus group said they would find different things like menstruation and travel far more useful, so it was decided that these should be customisable and users should be able to create their own tags. While there hasn’t been time to implement this since the focus group it would ultimately be done either via the settings menu or directly in the health domain.
      
**11.   Status indicators**

Status indicators were a key part of the initial client design and one of the key advantages of the chosen architecture.  When discussing what these indicators should contain several ideas were generated, so it was decided that each section should have multiple status indicators which the user could swipe through the get as much information as possible. This features has not yet been implemented.
      
**12.   Current blood glucose**

In the original design current blood glucose is displayed in one of the status indicators which is reasonably small and not visible if that section has been selected. Given the importance of always having access to this figure it was decided to put it in large letters at the top of the bi-focal display. The trajectory arrow was suggested by the focus group and will be implemented in the next stage of project development.
