//
//  MapMarker.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 16/05/2022.
//

import SwiftUI

struct CustomMapMarker: View {
    
    let isFav: Bool
    let name: String
    
    @State private var isNameVisible: Bool = false
    
    var body: some View {
        
        VStack(alignment: .center) {
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(isFav ? .yellow : .red)
                .frame(width: 20, height: 20, alignment: .center)
                .background(Color("background"))
                .cornerRadius(10)
                .onTapGesture {
                    isNameVisible.toggle()
                }
            
            Text(name)
                .padding(.all, 5)
                .background(Color("background"))
                .font(.subheadline)
                .foregroundColor(.white)
                .cornerRadius(10)
                .opacity(isNameVisible ? 1 : 0)
                .animation(.easeOut(duration: 0.5), value: isNameVisible)
        }
    }
}

struct CustomMapMarker_Previews: PreviewProvider {
    static var previews: some View {
        CustomMapMarker(isFav: true, name: "Apple Tree")
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
    }
}
