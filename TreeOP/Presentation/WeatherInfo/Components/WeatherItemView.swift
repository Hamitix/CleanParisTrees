//
//  WeatherView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 21/04/2022.
//

import SwiftUI

struct WeatherItemView: View {
    
    var value: String
    var valueState: WeatherInfoState
    
    let labelTitle: String.LocalizationValue
    var iconName: String.LocalizationValue
    
    var body: some View {
        
        HStack(alignment: .center) {
            Label(String(localized: labelTitle), systemImage: String(localized: iconName))
            
            switch valueState {
            case .errorNetwork:
                Text("cannotProcessData")
                
            case .loading:
                ProgressView()
                    .padding(.horizontal)
                
            default:
                Text(value)
            }
        }
        .padding()
        .accessibilityElement(children: .combine)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherItemView(value: "10 °C" ,valueState: .loading, labelTitle: "Temperature", iconName: "thermometerIcon")
    }
}
