//
//  WeatherInfoView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 14/04/2022.
//

import SwiftUI

struct WeatherInfoView: View {
    
    @StateObject private var weatherInfoViewModel: WeatherInfoViewModel
    
    init (viewModel: WeatherInfoViewModel = .init(latitude: K.Map.latParis, longitude: K.Map.longParis)) {
        _weatherInfoViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            
            Spacer()
            
            Text("Paris")
                .titleStyle()
            
            Divider()
            
            WeatherView(temp: weatherInfoViewModel.weather)
            
            Divider()
            
            AirQualityView(aqiDesc: weatherInfoViewModel.aqiDescription)
            
            Divider()
            
            Spacer()
        }
        .task {
            await weatherInfoViewModel.getWeatherData()
            await weatherInfoViewModel.getAQData()
        }
        
        .overlay(alignment: .bottom, content: {
            if weatherInfoViewModel.networkMonitor.fetchStrategy == .local {
                NoConnectionView()
            }
        })
    }
}

struct InfosView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInfoView()
    }
}
