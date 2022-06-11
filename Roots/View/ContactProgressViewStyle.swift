//
//  ContactProgressViewStyle.swift
//  Roots
//
//  Created by Miles Wilson on 12/24/21.
//

import SwiftUI

struct ContactProgressViewStyle: ProgressViewStyle {
    var theme: Theme
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(.tertiary)
                .frame(height: 20.0)
            if #available(iOS 15.0, *) {
                ProgressView(configuration)
                    .tint(theme.mainColor)
                    .frame(height: 12.0)
                    .padding(.horizontal)
            } else {
                ProgressView(configuration)
                    .frame(height: 12.0)
                    .padding(.horizontal)
            }
        }
    }
}
    
struct ContactProgressViewStyle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(value: 0.4)
            .progressViewStyle(ContactProgressViewStyle(theme: .buttercup))
            .previewLayout(.sizeThatFits)
    }
}
    
    
    
