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
            
            // Refresh Button
            HStack {
                Spacer()
                Button {
                    Task {
                        await weatherInfoViewModel.getAllWeatherData(forceRefresh: true)
                    }
                } label: {
                    Image(systemName: String(localized:"refreshArrowIcon"))
                        .padding()
                        .foregroundColor(.primary)
                }
            }
            
            Spacer()
            
            Text("Paris")
                .titleStyle()
            
            Divider()
            
            // Temperature
            WeatherItemView(value: weatherInfoViewModel.getTemperatureValue(), valueState: weatherInfoViewModel.weatherState, labelTitle: "Temperature", iconName: "thermometerIcon")
            
            Divider()
            
            // Air Quality
            WeatherItemView(value: weatherInfoViewModel.getAqiValue(), valueState: weatherInfoViewModel.aqiState, labelTitle: "Air Quality", iconName: "aqiIcon")
            
            Divider()
            
            Spacer()
        }
        .task {
            await weatherInfoViewModel.getAllWeatherData()
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
