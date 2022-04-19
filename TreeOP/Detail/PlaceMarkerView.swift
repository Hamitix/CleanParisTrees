//
//  PlaceMarkerView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 19/04/2022.
//

import SwiftUI

struct PlaceMarkerView: View {
    
    @State private var showTitle = false
    
    let title: String?
    
    var body: some View {
        VStack(spacing: 0) {
            if (title != nil ) {
                Text(title!)
                    .font(.callout)
                    .padding(5)
                    .background()
                    .cornerRadius(10)
                    .opacity(showTitle ? 1 : 0)
            }
            
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(.red)
            
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(.red)
                .offset(x: 0, y: -5)
        }
        .onTapGesture {
            withAnimation(.easeInOut) {
                showTitle.toggle()
            }
        }
    }
}


struct PlaceMarkerView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceMarkerView(title: "Pin")
    }
}
