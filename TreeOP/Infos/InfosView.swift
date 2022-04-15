//
//  AirInfoView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 14/04/2022.
//

import SwiftUI

struct InfosView: View {
    
    @StateObject var infosViewModel: InfosViewModel
    
    init (viewModel: InfosViewModel = .init(latitude: K.latParis, longitude: K.longParis)) {
        _infosViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            Text("Paris")
                .titleStyle()
            
            Divider()
            
            HStack {
                Label(LocalizedStringKey("Temperature"), systemImage: "thermometer")
                if(infosViewModel.weather == 0) {
                    ProgressView()
                        .padding(.horizontal)
                } else {
                    Text(String(format: "%.1f", infosViewModel.weather) + " °C")
                }
            }
            
            Divider()
            
            AirQualityView(aqIDesc: infosViewModel.aqiDescription)
        }
        .onAppear {
            if(infosViewModel.weather == 0) {
                infosViewModel.getWeatherData()
            }
            
            if(infosViewModel.airQuality == 0) {
                infosViewModel.getAQData()
            }
        }
    }
    
}

struct InfosView_Previews: PreviewProvider {
    static var previews: some View {
        InfosView()
    }
}
