//
//  RootsApp.swift
//  Roots
//
//  Created by Miles Wilson on 12/19/21.
//

import SwiftUI

@main
struct RootsApp: App {
    @State var contacts: [Contact] = Contact.SampleContacts
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContactsView(contacts: $contacts)
            }
        }
    }
}
