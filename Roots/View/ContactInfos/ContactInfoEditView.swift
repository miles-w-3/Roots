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
        ContactInfoEditView(editData: .constant(Contact.EditData()))
    }
}
