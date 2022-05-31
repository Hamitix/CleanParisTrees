//
//  MapMarker.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 16/05/2022.
//

import SwiftUI

struct CustomMapMarker: View {
    
    @State var isFav: Bool
    
    var body: some View {
            Image("Leaf")
                .font(.title)
                .foregroundColor(isFav ? .yellow : .black)
                .frame(width: 20, height: 20, alignment: .center)
                .padding()
                .cornerRadius(10)
    }
}

struct CustomMapMarker_Previews: PreviewProvider {
    static var previews: some View {
        CustomMapMarker(isFav: true)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
