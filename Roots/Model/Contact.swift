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
         remindTime: Date, // Today's datem set at the time the user wants to be reminded TODO: day will be set be constructor to today + given interval
         contactInterval: Int,
         theme: Theme,
         birthday: Date? = nil) {
        self.prevDate = remindTime
        self.contactInterval = contactInterval
        self.name = name
        self.birthday = birthday
        self.theme = theme
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

    //
    var reminderTimeLabel: some View {
        // show message in red for due reminder
        if (self.due) {
            return AnyView(Label("\(reminderTime) Hours overdue", systemImage: "clock.badge.exclamationmark.fill").font(.footnote).foregroundColor(.red).padding(4).labelStyle(.trailingIcon))
        }
        // show blue message for valid remimder
        return AnyView(Label("\(reminderTime) Hours overdue", systemImage: "clock.badge.exclamationmark.fill").font(.footnote).foregroundColor(.red).padding(4).labelStyle(.trailingIcon))
    }
    
    // format string of the time of the reminder in days, or hours if less than a day left
    private var reminderTime: String {
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
    
    // True if the current time is greater than or equal to the next date
    var due: Bool {
        let now = Date()
        return now >= self.nextDate
    }
    
    // Increment the old date to the nextDate, increment nextDate by interval
    mutating func incrementReminderDate() {
        // increment the old
        self.prevDate = self.nextDate
        setNextDate()
    }
    
    // person was contacted, reset their time since contact TODO: Either do an in-time flag or check the current date against nextDate
//    mutating func markContacted() {
//        timeSinceContact = 0
//    }
    
    // TODO: Also modify the interval with the current date
    mutating func changeInterval(newInterval: Int, newTime: Date) {
        self.contactInterval = newInterval
    }
    
    
    // set the next date based on the current date and the interval
    private mutating func setNextDate() {
        if let undrappedDate = self.prevDate {
            var dateComp = DateComponents()
            dateComp.day = self.contactInterval
            self.nextDate = Calendar.current.date(byAdding: dateComp, to: undrappedDate)!
        }
    }
}


// TODO: Extenstion for edit data subclass that can be saved on new creation or voided if editing/creation is cancelled
extension Contact {
    struct EditData {
        // name of the contact
        var name: String? = nil
        var contactInterval: Int? = nil
        var reminderTime: Date
        var theme: Theme? = nil
        var birthday: Date? = nil
    }
    
    // Apply all non-nil values to the Contact
    mutating func apply(newData: EditData) {
        if let unwrappedName = newData.name {
            self.name = unwrappedName
        }
        
        if let unwrappedContactInterval = newData.contactInterval {
            self.contactInterval = unwrappedContactInterval
        }
        
    
        self.prevDate = newData.reminderTime
        self.setNextDate();
        
        if let unwrappedTheme = newData.theme {
            self.theme = unwrappedTheme
        }
        if let unwrappedBday = newData.birthday {
            self.birthday = unwrappedBday
        }
    }
}


extension Contact {
    static let SampleContacts: [Contact] =
    [
        Contact(name: "John Doe", remindTime: Date(), contactInterval: 24,  theme: .orange),
        Contact(name: "Chris Cringle", remindTime: Date(), contactInterval: 7, theme: .bubblegum),
        Contact(name: "Eilliam Wella", remindTime: Date(), contactInterval: 4, theme: .indigo),
        Contact(name: "Shris Carp", remindTime: Date(), contactInterval: 8, theme: .seafoam, birthday: Date(timeIntervalSinceReferenceDate: 0))
    ]
    
}
