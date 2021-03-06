# Ethics Report

## Benefits
</br>
### Diabetes Management

The purpose of the app is to help patients track their blood glucose levels and receive better estimates for how
much insulin they need to take. This will make them substantially less likely to experience hypo or hyperglycaemia which can lead to
serious health complications that can now be prevented. Even excluding extreme events, better blood glucose control in the long
term can lead to a reduction in Hb1ac levels (a long term measure of glucose control), which according to a recent study if reduced by only 1.5% can lead to an increase in life expectancy of 23 years (roze et al).

Furthermore, being able to follow trends in the health and advice section can help patients better understand what factors affect their blood glucose levels and spot long term trends before they become an urgent problem.
</br>
### Government Spending

In 2010/11 diabetes cost the UK government £23.7 billion in both direct costs to the NHS and indirect costs in loss of productivity from time taken off work (N, C, Wright, M, & D, 2012). Being able to spot problems early and avoid them in the first place will lead to huge savings for the government as patients will have to visit A&amp;E less, which is the most expensive form of treatment. Furthermore, less
complications will mean less time will need to be taken off work, which will be beneficial for the economy as a whole.

## Concerns
</br>
### Data Protection

The app stores records of the user's blood glucose levels, exercise and eating habits on a local database and this information would be extremely valuable for use in targetted advertising. If a corporation knew what exercise types someone did, they could send them adverts for support equipment for that activity, or they could work out where the user buys their food based on it's nutritional information. The likelihood of this data being sold off to third parties is extremely low, because the NHS is a government agency whose main incentive is patient protection, as opposed to profit. Furthermore if this information was sold off it would reflect very poorly on the government that made that decision and would severely harm their chances at re-election.

To mitigate the risk of illegal theft of the data the database should be encrypted, although storing the data locally already largely removes that risk, since a hacker would need access to the actual phone to even attempt to acquire it. Since the data storage does not take that much memory it is feasible to keep the data stored locally and even preferable, from the user's perspective, as this will allow the app to work without an internet connection.

When the user changes phone their data will need to be uploaded to an online storage system so they can download it onto the new device and avoid losing all their data. The option to do this will need to be accessed via settings to avoid permanent online storage and it will need to be deleted as soon as it has been downloaded to mitigate the risks described above. Alternatively, it could be exported to a local file and imported directly into the new device, to remove the risks involved with uploading data.
</br>
### Insulin Dose Miscalculation

Bugs in the algorithm could lead to miscalculation of an insulin dose, which a patient might follow and subsequently enter hypo/hyperglycaemia. To mitigate this, it would be wise to have as much information as possible about how the dosage was calculated available (i.e. how much of it is basal correction, how much is meal correction etc.) to let the user sanity check the result. A rigorous testing process on the eventual algorithm will have to be carried out to quantify and minimise this risk, however this does not relate to the part of the project we are working on.

---
### References

N, H., C, B., Wright, D., M, T., & D, V. (2012). Estimating the current and future costs of Type 1 and
  Type 2 diabetes in the UK, including direct health costs and indirect societal and productivity
  costs. Diabetic Medicine, 29(7), 855-862. Retrieved 8 7, 2017, from
  http://onlinelibrary.wiley.com/doi/10.1111/j.1464-5491.2012.03698.x/abstract 
  
Roze, S., Smith-Palmer, J., Valentine, W., M, C., M, J., S, d. P., & Jc, P. (2016). Long-term health
  economic benefits of sensor-augmented pump therapy vs continuous subcutaneous insulin
  infusion alone in type 1 diabetes: a U.K. perspective. Journal of Medical Economics, 19(3),
  236-242. Retrieved 8 7, 2017, from
  http://tandfonline.com/doi/full/10.3111/13696998.2015.1113979?src=recsys 
  

