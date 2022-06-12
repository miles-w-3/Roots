//
//  ContactListView.swift
//  Roots
//
//  Created by Miles Wilson on 12/22/21.
//


// View
import SwiftUI

struct ContactCardView: View {
    // the contact whose info will be displayed
    let contact: Contact
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // name of the contact
                Text(contact.name)
                    .font(.headline)
                    .padding(4)
                Spacer()
                contact.reminderTimeLabel
                
            }
            // Contact timeline bar
            ProgressView(value: contact.contactProgress)
                .progressViewStyle(ContactProgressViewStyle(theme: contact.theme)).padding(4)
        }
    }
}

struct ContactCardView_Previews: PreviewProvider {
    static let sample_contact = Contact.SampleContacts[1]
    static var previews: some View {
        ContactCardView(contact: sample_contact)
            .background(sample_contact.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
