//
//  WeatherInfoView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 14/04/2022.
//

import SwiftUI

struct WeatherInfoView: View {
    
    @StateObject private var infosViewModel: WeatherInfoViewModel
    
    init (viewModel: WeatherInfoViewModel = .init(latitude: K.latParis, longitude: K.longParis)) {
        _infosViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            Text("Paris")
                .titleStyle()
            
            Divider()
            
            WeatherView(temp: infosViewModel.weather)
            
            Divider()
            
            AirQualityView(aqiDesc: infosViewModel.aqiDescription)
        }
        .task {
            await infosViewModel.getWeatherData()
            await infosViewModel.getAQData()
        }
    }
}

struct InfosView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInfoView()
    }
}
