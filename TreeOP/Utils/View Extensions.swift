//
//  View Extensions.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 12/04/2022.
//

import SwiftUI

// MARK: Text
extension Text {
    func titleStyle() -> some View {
        self
            .bold()
            .font(.title2)
            .textCase(.uppercase)
            .padding(.vertical, 5)
    }
}
