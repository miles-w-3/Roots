//
//  Contact.swift
//  Roots
//
//  Created by Miles Wilson on 12/22/21.
//

import Foundation
import SwiftUI

struct Contact : Identifiable {
    // unique id for each contact
    let id: UUID = UUID()
    var name: String
    // stores when the previous reminder happened (or on init, the time the contact was created)
    var prevDate: Date!
    // stores the time the next reminder will happen
    var nextDate: Date
    // contact interval in days, used to set the new date from the current reminder time
    var contactInterval: Int
    var theme: Theme
    var birthday: Date?
    
    
    init(name: String,
         remindTime: Date, // Today's date set at the time the user wants to be reminded
         contactInterval: Int,
         theme: Theme,
         birthday: Date? = nil) {
        self.prevDate = remindTime
        self.contactInterval = contactInterval
        self.name = name
        self.birthday = birthday
        self.theme = theme
        // set default next date so that function can be called
        self.nextDate = prevDate
        self.setNextDate()
    }
    
    
    
    // return contract interval fraction for progress bar
    var contactProgress: Double {
        // get the time in seconds from the prev to next date
        let totalTime = self.prevDate.distance(to: self.nextDate)
        // get the time in seconds between the prev date and the current date
        let completedTime = self.prevDate.distance(to: Date())
        
        return completedTime / totalTime
    }

    // return a label containing the reminder time
    var reminderTimeLabel: some View {
        // show message in red for due reminder
        if (self.due) {
            return AnyView(Label("\(timeTilContact) Hours overdue", systemImage: "clock.badge.exclamationmark.fill").font(.footnote).foregroundColor(.red).padding(4).labelStyle(.trailingIcon))
        }
        // show blue message for valid remimder
        return AnyView(Label("\(timeTilContact)", systemImage: "clock.badge.exclamationmark.fill").font(.footnote).foregroundColor(.blue).padding(4).labelStyle(.trailingIcon))
    }
    
    // format string of the time of the reminder in days, or hours if less than a day left
    var timeTilContact: String {
        let rightNow = Date()
        // get hour diff
        let hourDiff: Int = Calendar.current.dateComponents([.hour], from: rightNow, to: self.nextDate).hour ?? 0
        let hourAbs = abs(hourDiff)
        // return a reminder time in hours
        if (hourAbs < 24) {
            // if time is still before reminder
            if (hourDiff > 0) {
                return "\(hourDiff) hours remaining"
            }
            // time is after reminder
            if (hourDiff < 0) {
                return "\(hourAbs) hours overdue"
            }
            // hourDiff is 0 TODO: Better message here, and do we want to go more in-depth to minutes?
            else {
                return "Time to contact!"
            }
        }
        // if the hour diff is geq a day, then we want unit in days instead
        else {
            let dayDiff: Int = Calendar.current.dateComponents([.day], from: rightNow, to: self.nextDate).day ?? 0
            let dayAbs = abs(dayDiff)
            // still time before the reminder
            if (dayDiff > 0) {
                return "\(dayDiff) days remaining"
            }
            // reminder is overdue
            else {
                return "\(dayAbs) days overdue"
            }
            // note that equals case is handled in the hour
        }
    }
    
    // True if the start time is within an hour of the current time
    var started: Bool {
        let now = Date()
        let diff = Calendar.current.dateComponents([.hour], from: self.prevDate, to: now).hour ?? 0
        return diff <= 1
    }
    
    // True if the current time is greater than or equal to the next date
    var due: Bool {
        let now = Date()
        return now >= self.nextDate
    }
    
    // person was contacted, reset their time since contact TODO: Either do an in-time flag or check the current date against nextDate
    mutating func markContacted() {
        incrementReminderDate(newDate: true)
    }
    
    // TODO: Also modify the interval with the current date
    mutating func changeInterval(newInterval: Int, newTime: Date) {
        self.contactInterval = newInterval
    }
    
    
    // TODO: Verify that this logic actually works, it might have to be more complicated
    // Increment the old date to the nextDate, increment nextDate by interval
    private mutating func incrementReminderDate(newDate: Bool = false) {
        // if we are incrementing the date based on a different time than the standard reminder - either contacted early or late
        if newDate {
            // move prevDate to today, but keep its time
            self.prevDate = todayAtTime(correctTime: self.prevDate)
        }
        else {
            // increment the old date if it is a standard movement
            self.prevDate = self.nextDate
        }
        
        setNextDate()
    }
    
    // set the next date based on the current date and the interval
    private mutating func setNextDate() {
        if let undrappedDate = self.prevDate {
            var dateComp = DateComponents()
            dateComp.day = self.contactInterval
            self.nextDate = Calendar.current.date(byAdding: dateComp, to: undrappedDate)!
        }
    }
    
    // refresh a date to be the current date at the time (hours, minutes seconds) of the given date
    private func todayAtTime(correctTime: Date) -> Date {
        let rightNow = Date()
        // get the time from the given date
        let timeComponent = Calendar.current.dateComponents([.hour, .minute, .second], from: rightNow)
        // get the hours, minutes, and seconds of prevDate so so we can set the proper reminder time on the given date
        let hour = timeComponent.hour ?? 0
        let minute = timeComponent.minute ?? 0
        let second = timeComponent.second ?? 0

        // now return a date representing the current day, set to the proper time
        return Calendar.current.date(bySettingHour: hour, minute: minute, second: second, of: rightNow)!
    }
}


// TODO: Extenstion for edit data subclass that can be saved on new creation or voided if editing/creation is cancelled
extension Contact {
    struct EditData {
        // name of the contact
        var name: String = ""
        var contactInterval: Int = 7
        var remindTime: Date = Date()
        var theme: Theme = .indigo
        var birthday: Date? = nil
    }
    
    var editData: EditData {
        EditData(name: name, contactInterval: contactInterval, remindTime: prevDate, theme: theme, birthday: birthday)
    }
    
    // Apply all non-nil values to the Contact
    mutating func apply(newData: EditData) {
        self.name = newData.name
        
        self.contactInterval = newData.contactInterval
        
        // set a new date with the given remind time
        self.prevDate = todayAtTime(correctTime: newData.remindTime)
        self.setNextDate();
        
        self.theme = newData.theme
        
        if let unwrappedBday = newData.birthday {
            self.birthday = unwrappedBday
        }
        
        self.setNextDate()
    }
}


extension Contact {
    static let SampleContacts: [Contact] =
    [
        Contact(name: "John Doe", remindTime: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, contactInterval: 24,  theme: .orange),
        Contact(name: "Chris Cringle", remindTime: Date(), contactInterval: 7, theme: .bubblegum),
        Contact(name: "Eilliam Wella", remindTime: Date(), contactInterval: 4, theme: .indigo),
        Contact(name: "Shris Carp", remindTime: Date(), contactInterval: 8, theme: .seafoam, birthday: Date(timeIntervalSinceReferenceDate: 0))
    ]
    
}
