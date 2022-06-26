//
//  ContactInfoView.swift
//  Roots
//
//  Created by Miles Wilson on 12/22/21.
//

import SwiftUI

// TODO: Show detailed information about a contact, allow a user to mark as contacted or edit values

struct ContactInfoView: View {
    // represents the contact being displayed
    @Binding var contact: Contact
    // represents updated values to edit
    @State private var editData: Contact.EditData = Contact.EditData()
    @State var inEditView: Bool = false
    
    static func getFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY/MM/dd"
        return formatter
    }
    
    var body: some View {
        List {
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
                .disabled(contact.started)
                .buttonStyle(BorderlessButtonStyle())
                .background(contact.theme.mainColor)
                .cornerRadius(15)
            }
            
            // List for additional contact information
            List {
                // display personal details including birthday, contact interval, and duration
                Section(header: Text("Details")) {
                    // show remaining time left for contact
                    // TODO: Click phone to call/text and it will automatically mark contacted
                    HStack {
                        Text(Image(systemName: "phone.fill")).foregroundColor(.blue)
                        Spacer()
                        Text("(202) 184-7679")

                    }
                    HStack {
                        Text("Last Contacted").foregroundColor(.blue)
                        Spacer()
                        Text(contact.prevDate.formatted())

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
            } //.font(.headline)
        }
        .navigationTitle(contact.name)
        .toolbar {
            Button(action: {
                inEditView = true
                editData = contact.editData
            }) {
                Image(systemName: "pencil")
            }
        }
        .sheet(isPresented: $inEditView) {
            NavigationView {
                ContactInfoEditView(data: $editData)
                    .navigationTitle(contact.name)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                inEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                inEditView = false
                                contact.apply(newData: editData)
                            }
                        }
                    }
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
