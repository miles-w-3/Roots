//
//  ContactInfoProgressView.swift
//  Roots
//
//  Created by Miles Wilson on 12/24/21.
//

import SwiftUI

// TODO: Progress bar with
struct ContactInfoProgressView: View {
    @Binding var contact: Contact
    
    var body: some View {
        VStack {
            ProgressView(value: contact.contactProgress)
                .progressViewStyle(ContactProgressViewStyle(theme: contact.theme))
            HStack {
                VStack(alignment: .leading) {
                    Text("Hours since contact")
                        .font(.callout)
                    Label("\(contact.timeSinceContact)", systemImage: "deskclock")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Hour interval")
                        .font(.callout)
                    Label("\(contact.contactInterval)", systemImage: "clock.arrow.2.circlepath")
                }
            }
        }
        .padding([.top, .horizontal])
    }
}

struct ContactInfoProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ContactInfoProgressView(contact: .constant(Contact.SampleContacts[0]))
            .previewLayout(.sizeThatFits)
    }
}
