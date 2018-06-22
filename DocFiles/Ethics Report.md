# Ethics Report

## Benefits

#### Diabetes Management

The purpose of this app is to help patients rack their blood glucose levels and have better estimates for how
much insulin they need to take. This will make them substantially less likely to experience hypo or hyperglycaemia which can lead to
serious health complications that can now be prevented. Even excluding extreme events better blood glucose control in the long
term can lead to a reduction in Hb1ac levels (a measure of long term glucose control) which if reduced by only 1.5% can lead to an increase in life expectancy of 23 years.

Furthermore, being able to follow trends in the health and advice section can help patients better understand what factors affect their blood glucose levels and spot long term trends before they become an urgent problem.

#### Government Spending

In 2010/11 diabetes cost the UK government £23.7 billion in both direct costs through the NHS and indirect costs in loss of productivity from time taken off work. Being able to spot problems early and avoid them in the first place will lead to huge savings for the government as patients will have to visit A&amp;E less which is the most expensive form of treatment. Furthermore, less
complications will mean less time will need to be taken off work, leading to further savings.

## Concerns

#### Data Protection

The app stores records of the users individual’s blood glucose levels, exercise and eating habits on a local database and this information would be extrememly valuable for use in targetted advertising. If, for instance, a corporation knew someone did yoga they could send them adverts for yoga pants or they could work out where the user buys their food based on it's nutritional information. However, The likelihood of this data being sold off to third parties is extrememly low, because the NHS is a government agency whose main incentive is patient protection as opposed to profit. Furthermore if this information was sold off it would reflect very poorly on the government that made that decision and would severly harm their chance at re-election.

To mitigate the risk further the database can be encrypted to make it harder for people to steal information from it, although storing the data locally already mitigates that risk to an extent as they would need access to the actual phone to even attempt to aqcuire it. Since the data storage does not take that much memory it is feasable to keep the data locally stored and even preferable from the user's perspective as this will allow the app to work without an internet connection.

#### Insulin Dose Miscalculaton

Bugs in the algorithm could lead to miscalculation of an insulin dose, which a patient might follow and go into hypo/hyperglycaemia. To mitigate this, it would be wise to have as much information as possible about how the dosage was calculated available (i.e. how much of it is basal correction, how much is meal correction etc.) to let the user sanity check the result. A rigorous testing process on the eventual algorithm will have to be carried out to quantify and minimise this risk, however this does not relate to the part of the project we are working on.
