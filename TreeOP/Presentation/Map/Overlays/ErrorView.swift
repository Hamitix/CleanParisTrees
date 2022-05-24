//
//  ErrorView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 24/05/2022.
//

import SwiftUI

struct ErrorView: View {

    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(systemName: "xmark.octagon")
            Text("ErrorMap")
                .font(.body)
        }
        .padding()
        .background(Color("background"))
        .cornerRadius(20)
        .padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
