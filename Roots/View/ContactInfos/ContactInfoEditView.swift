//
//  ContactInfoEditView.swift
//  Roots
//
//  Created by Miles Wilson on 12/24/21.
//

import SwiftUI

struct ContactInfoEditView: View {
    // An edit data passed by the ContactInfoView
    @Binding var editData: Contact.EditData
    
    var body: some View {
        List {
            Section(header: Text("Edit interval")) {
                
            }
            
        }
    }
}

struct ContactInfoEditView_Previews: PreviewProvider {
    static var previews: some View {
        let testEditData = Contact.EditData(baseContact: Contact.SampleContacts[0])
        ContactInfoEditView(editData: Contact.EditData(baseContact: .constant(Contact.SimpleContacts[0]))).previewInterfaceOrientation(.portrait)
    }
}
