//
//  AQView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 14/04/2022.
//

import SwiftUI

struct AirQualityView: View {
    
    let aqIndex: Double
    let aqIDesc: String
    
    var body: some View {
        VStack(alignment: .center) {
            
            HStack(alignment: .center) {
                
                Label(LocalizedStringKey("Air Quality"), systemImage: "aqi.medium")
                if(aqIndex == 0) {
                    ProgressView()
                        .padding(.horizontal)
                } else {
                    Text(String(format: "%.0f", aqIndex))
                }
            }
            .padding()
            
            Text("Description \(aqIDesc)")
        }
    }
}

struct AirQualityView_Previews: PreviewProvider {
    static var previews: some View {
        AirQualityView(aqIndex: 40, aqIDesc: "Good")
    }
}
