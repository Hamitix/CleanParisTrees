//
//  AQView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 14/04/2022.
//

import SwiftUI

struct AirQualityView: View {
    
    let aqIDesc: String
    
    var body: some View {
        VStack(alignment: .center) {
            
            HStack(alignment: .center) {
                
                Label(LocalizedStringKey("Air Quality"), systemImage: "aqi.medium")
                if(aqIDesc == "") {
                    ProgressView()
                        .padding(.horizontal)
                } else {
                    Text(LocalizedStringKey(aqIDesc.description))

                }
            }
            .padding()
        }
    }
}

struct AirQualityView_Previews: PreviewProvider {
    static var previews: some View {
        AirQualityView(aqIDesc: "Good")
    }
}
