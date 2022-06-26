//
//  ThemePicker.swift
//  Roots
//
//  Created by Miles Wilson on 6/26/22.
//

import SwiftUI

struct ThemePicker: View {
    
    @Binding var selected: Theme
    
    var body: some View {
        Picker("Theme", selection: $selected) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ThemePicker(selected: .constant(.teal))
    }
}
