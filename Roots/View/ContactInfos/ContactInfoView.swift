//
//  ContactInfoView.swift
//  Roots
//
//  Created by Miles Wilson on 12/22/21.
//

import SwiftUI

// TODO: Show detailed information about a contact, allow a user to mark as contacted or edit values

struct ContactInfoView: View {

    @Binding var contact: Contact
    
    @State var inEditView: Bool = false
    
    static func getFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY/MM/dd"
        return formatter
    }
    
    var body: some View {
        VStack {
            Spacer()
            // VStack for card summary
            VStack (alignment: .center, spacing: 20) {
                // Display the contact info progress
                ContactInfoProgressView(contact: $contact)
                // Mark the user as contacted
                Button(action: {contact.markContacted()}) {
                    Text("Mark Contacted")
                        .foregroundColor(contact.theme.accentColor)
                        .font(.title)
                        .padding(5)
                }
                .buttonStyle(BorderlessButtonStyle())
                .background(contact.theme.mainColor)
                .cornerRadius(15)
            }
            
            // List for new information
            List {
                let txt = contact.reminderTime
                // display personal details including birthday, contact interval, and duration
                Section(header: Text("Details")) {
                    // show remaining time left for contact
                    HStack {
                        if (contact.due) {
                            Label("Time overdue", systemImage: "hourglass.tophalf.filled")
                            Spacer()
                            Text(txt)
                        }
                        else {
                            Label("Time remaining", systemImage: "hourglass")
                            Spacer()
                            Text(txt)
                        }
                    }
                    // Show birthday if the contact's is in the system
                    if let bday_sure = contact.birthday {
                        // TODO: could do special highlight if birthday is today
                        HStack {
                            Label("Birthday", systemImage: "calendar.circle")
                            Spacer()
                            Text(ContactInfoView.getFormatter().string(from: bday_sure))
                        }
                    }
                }
            }.font(.headline)
        }
        .navigationTitle(contact.name)
        .toolbar {
            Button(action: {inEditView = true}) {
                Image(systemName: "pencil")
            }
        }
    }
}

struct ContactInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ContactInfoView(contact: .constant(Contact.SampleContacts[0]))
            .previewInterfaceOrientation(.portrait)
    }
}
