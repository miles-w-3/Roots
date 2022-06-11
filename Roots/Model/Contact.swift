//
//  Contact.swift
//  Roots
//
//  Created by Miles Wilson on 12/22/21.
//

import Foundation

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
    // TODO: Time since contact will be a float, fractions less than one represent hours left
    var timeSinceContact: Double
    var theme: Theme
    var birthday: Date?
    
    
    init(name: String,
         contactTime: Date, // Today's datem set at the time the user wants to be reminded TODO: day will be set be constructor to today + given interval
         contactInterval: Int,
         timeSinceContact: Double = 0,
         theme: Theme,
         birthday: Date? = nil) {
        self.prevDate = contactTime
        self.contactInterval = contactInterval
        self.setNextDate()
        self.name = name
        self.birthday = birthday
        self.theme = theme
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
    var remainingContactTime: Int {
         contactInterval - timeSinceContact
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
    mutating func markContacted() {
        timeSinceContact = 0
    }
    
    // TODO: Als
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
        var theme: Theme? = nil
        var birthday: Date? = nil
    }
    
    // Apply all non-nil values to the Contact
    mutating func apply(newData: EditData) {
        // Track if contact interval has been mutated so that it deosn't get overridded during multiple conversions
        var mutatedInterval = false
        
        
        if let unwrappedName = newData.name {
            self.name = unwrappedName
        }
        
        if let unwrappedInterval = newData.contactInterval {
            self.contactInterval = unwrappedInterval
        }
        
        // set contact interval based on hours and weeks
        if let unwrappedIntervalD = newData.contactIntervalD {
            self.contactInterval = unwrappedIntervalD
            mutatedInterval = true // set true so that weeks can add on
        }
        // set contact interval based on hours and weeks
        if let unwrappedIntervalW = newData.contactIntervalW {
            // if hours were not overidden, then just override here
            if (!mutatedInterval) {
                self.contactInterval = unwrappedIntervalW
            }
            // otherwise, add to the already-overidded value
            else {
                // multiply week interval by the number of days in a week to convert, then add to interval
                self.contactInterval += (unwrappedIntervalW * 7)
            }
        }
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
        Contact(name: "John Doe", contactInterval: 24, timeSinceContact: 4, theme: .orange),
        Contact(name: "Chris Cringle", contactInterval: 36, timeSinceContact: 0, theme: .bubblegum),
        Contact(name: "Eilliam Wella", contactInterval: 4, timeSinceContact: 6, theme: .indigo),
        Contact(name: "Shris Carp", contactInterval: 8, timeSinceContact: 6, theme: .seafoam, birthday: Date(timeIntervalSinceReferenceDate: 0))
    ]
    
}
