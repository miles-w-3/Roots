//
//  ContactInfoEditView.swift
//  Roots
//
//  Created by Miles Wilson on 12/24/21.
//

import SwiftUI

struct ContactInfoEditView: View {
    // An edit data passed by the ContactInfoView
    @Binding var data: Contact.EditData
    
    private var days = 0
    private let day_range = 1...365
    
    init(data: Binding<Contact.EditData>) {
        self._data = data
    }
    
    var body: some View {
        Form {
            Picker("Choose interval", selection: $data.contactInterval) {
                ForEach(self.day_range, id: \.self) {
                    Text(String($0))
                }
            }
            DatePicker(selection: $data.remindTime, in: ...Date(), displayedComponents: .hourAndMinute) {
                Text("Select reminder time")
            }
        }
    }
}

struct ContactInfoEditView_Previews: PreviewProvider {
    static var previews: some View {
        ContactInfoEditView(data: .constant(Contact.SampleContacts[0].editData)).previewInterfaceOrientation(.portrait)
    }
}
