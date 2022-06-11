//
//  IntervalPickerView.swift
//  Roots
//
//  Created by Miles Wilson on 12/24/21.
//

import SwiftUI

struct IntervalPickerView: View {
    @Binding var data: Contact.EditData
    
    // allow selection of up to 6 days, can roll over to weeks
    private let days = 0

    static let day_range = [0...365]
    init(editData: Binding<Contact.EditData>) {
        self._data = editData
    }
    
    var body: some View {
        Form {
            Picker("Interval", selection: $data.co) {
                ForEach(IntervalPickerView.day_range) { day in
                    Text(day)
                }
            }
        }
        
        /*GeometryReader { geometry in
            // TODO: Probably remove all geometry, remove w and h, add dynamically updating "weeks: days: in state below
            HStack(spacing: 0) {
                // select weeks
                Picker(selection: self.$data.contactIntervalW, label: Text("")) {
                    ForEach(0 ..< self.weeks.count) { index in
                        Text("\(self.weeks[index]) w").tag(index)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width/2, height: geometry.size.height, alignment: .center)
                .compositingGroup()
                .clipped()
                // select days
                Picker(selection: self.$data.contactIntervalD, label: Text("")) {
                    ForEach(0 ..< self.days.count) { index in
                        Text("\(self.days[index]) h").tag(index)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width/2, height: geometry.size.height, alignment: .center)
                .compositingGroup()
                .clipped()
            }*/
        }
    }
}

struct IntervalPickerView_Previews: PreviewProvider {
    static var previews: some View {
        IntervalPickerView(editData: .constant(Contact.EditData()))
    }
}
