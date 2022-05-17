//
//  NoConnectionView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 13/05/2022.
//

import SwiftUI

struct NoConnectionView: View {
    var body: some View {
        
        HStack(alignment: .center, spacing: 20) {
            Image(systemName: "wifi.slash")
                .symbolRenderingMode(.hierarchical)
            
            Text("notConnectedError")
        }
        .padding()
        .background(Color("background"))
        .cornerRadius(20)
        .padding(.bottom)
    }
}

struct NoConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        NoConnectionView()
            .preferredColorScheme(.dark)
    }
}
