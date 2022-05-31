//
//  CenterOnUserIcon.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 16/05/2022.
//

import SwiftUI

struct CenterLocationIcon: View {
    var body: some View {
        
        Image(systemName: "location.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40, alignment: .center)
            .foregroundColor(.blue)
            .background(Color("background"))
            .cornerRadius(20)
            .padding(5)
    }
}

struct CenterOnUserIcon_Previews: PreviewProvider {
    static var previews: some View {
        CenterLocationIcon()
            .previewLayout(.sizeThatFits)
    }
}
