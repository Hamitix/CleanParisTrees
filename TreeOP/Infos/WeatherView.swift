//
//  WeatherView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 21/04/2022.
//

import SwiftUI

struct WeatherView: View {
    
    var temp: Double?
    
    var body: some View {
        
        HStack(alignment: .center) {
            Label(LocalizedStringKey("Temperature"), systemImage: "thermometer")
            
            switch temp {
            case nil:
                Text("Couldn't proccess data")
                
            case 0:
                ProgressView()
                    .padding(.horizontal)
                
            default:
                Text(String(format: "%.1f", temp!) + " °C")
            }
        }
        .padding()
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
