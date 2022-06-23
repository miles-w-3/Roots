#  <#Title#>
- BIG TODO: Change program paradigm to be around days instead of hours
# Contact features
- Picture?
- Display birthday
    - Birthday cake icon in main menu and on details when it's someone's birthday
    - In edit menu, add day/month/year slider when editing
- Option to notify on birthday
- Option to notify on overdue

# Working on EditView
- Finish ContactInfo EditView:
- Interval will have scrollers that allow selection of week and month
    - The EditView should not allow save day and week intervals are zero
- Birthday could use Similar dual scroller for day, month, then change birthday format to be like "January 25th" instead of the date (that format if possible, otherwise use mm/dd i guess)
- Allow name edit in separate section at the top, labeled "Contact name"
- Eventually "clear notes" option for note file



# Working on CreateViews
- Will flow from editview, similar options but maybe more description
- What fields, if any, cannot or should not be changed? (ie they would appear here but not in editView)


# Movement in time and Remdinders logic
## Rules
- When creating a contact, you define an interval and a time to remind
- At the time you create the contact and set those values, your first reminder will be $interval days at the specified time to remind
- Under the hood:
    - interval gets stored as int contactInterval
    - the selected remind time will be stored in a Date called rootDate, $interval days from now
    - each time rootDate is reached, it gets incremented by the interval
    - Design decision below on whether it should be incremented by contactInterval or by (contactInterval + daysOverdue)

### Design Decision
So the user doesn't contact the person until 6 days on a 5 day interval...
Should the next interval be 5 days away or four? i.e. is the interval regular or since the last contact
* the question is whether it's an interval for the reminder or actually for when the last contact happened
* Maybe there is a "Rolling interval" checkbox 

### Another decision: The interval is edited 
- When the interval is updated, either:
1. The rootDate gets updated with the new interval based on the current date: $currentDate + interval
2. More complex solution adaoting the new date -- I don't think I want to 
    - but if the new interval is bigger, keep the current progress
    - if the interval is smaller, then reset it? IDK this might be too convoluted

Note that on the dot, there will be a prompt to directly set the interval - i guess this is the only time you don't create a new date

### Birthday reminders
User inputs a birthday for a contact - do they automatically want a reminder then? for now I'm thinking yes
There could be a whole list of custom specifications to remind




