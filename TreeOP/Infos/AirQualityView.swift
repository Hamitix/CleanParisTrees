//
//  AQView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 14/04/2022.
//

import SwiftUI

struct AirQualityView: View {
    
    let aqiDesc: String
    
    var body: some View {
        
        HStack(alignment: .center) {
            
            Label(LocalizedStringKey("Air Quality"), systemImage: "aqi.medium")
            
            if aqiDesc == "" {
                ProgressView()
                    .padding(.horizontal)
            } else {
                Text(LocalizedStringKey(aqiDesc.description))
            }
        }
        .padding()
    }
}

struct AirQualityView_Previews: PreviewProvider {
    static var previews: some View {
        AirQualityView(aqiDesc: "Good")
    }
}
