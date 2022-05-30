//
//  WeatherInfoView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 14/04/2022.
//

import SwiftUI
import Resolver

struct WeatherInfoView: View {
    
    @InjectedObject var weatherInfoViewModel: WeatherInfoViewModel
    
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
