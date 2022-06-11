//
//  ContentView.swift
//  Roots
//
//  Created by Miles Wilson on 12/19/21.
//

import SwiftUI

struct ContactsView: View {
    @Binding var contacts: [Contact]
    
    var body: some View {
        List {
            ForEach($contacts) { $contact in
                NavigationLink(destination: ContactInfoView(contact: $contact)) {
                    ContactCardView(contact: contact)
                }
            }
        }.navigationTitle("Connections")            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactsView(contacts: .constant(Contact.SampleContacts))
        }
    }
}
