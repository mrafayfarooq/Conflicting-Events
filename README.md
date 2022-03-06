The project is using simple Table View Controller to display the data.
After loading the data we sort the events using their start time to
display the events chronologically. Once sorted, we create an augmented
interval binary tree to find the conflicting events. We also create 
sorted sections from the events so we can group the events 
chronologically. At the end, the list displays all the events group by 
dates and in chronological order.

## Time Complexity Analysis:
- We are using swift ```sorted``` function which has the run time complexitiy of ```O(nlog(n))```
- We are using Augmented Interval Binary Search tree to find the conflicting events which has the runtime complexity of ```O(nlog(n))``` for creation and ```O(logN)``` for collision query.

Total Runtime Complexity is O(nlog(n) + log(n)) = O(nlog(n))

### References 
- https://github.com/klyatskin/klyatskin.github.io
- https://www.raywenderlich
.com/1000705-model-view-controller-mvc-in-ios-a-modern-approach


### Improvements for future
- Make the loading class generic to make it easily reusable for other objects
- Improve UI to give space for Safe Area





