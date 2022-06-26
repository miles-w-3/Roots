//
//  ContentView.swift
//  Roots
//
//  Created by Miles Wilson on 12/19/21.
//

import SwiftUI

struct ContactsView: View {
    @Binding var contacts: [Contact]
    @State var showingAddView: Bool = false 
    
    var body: some View {
        List {
            ForEach($contacts) { $contact in
                NavigationLink(destination: ContactInfoView(contact: $contact)) {
                    ContactCardView(contact: contact)
                }
            }
        }
        .navigationTitle("Connections")
        .toolbar {
            Button(action: {}) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Scrum")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactsView(contacts: .constant(Contact.SampleContacts))
        }
    }
}
