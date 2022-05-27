//
//  WeatherInfoViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 14/04/2022.
//

import Foundation
import Resolver

class WeatherInfoViewModel: ObservableObject {
    
    @Injected var networkMonitor: NetworkMonitor
    
    private var airQuality: Int = 0
    @Published var aqiDescription: String = ""
    @Published var weather: Double = 0
    
    @Published var weatherState: WeatherInfoState = .loading
    @Published var aqiState: WeatherInfoState = .loading
    
    private let latitude: Double
    private let longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    @Injected var getWeatherUseCase: GetWeather
    @Injected var getAirQualityUseCase: GetAirQuality

    func getAllWeatherData(forceRefresh: Bool = false) async {
        await getAQData(forceRefresh)
        await getWeatherData(forceRefresh)
    }
    
    private func getWeatherData(_ forceRefresh: Bool = false) async {
        
        if !forceRefresh && weatherState == .loaded {
            return
        }
        
        DispatchQueue.main.async {
            self.weatherState = .loading
        }
        
        let result = await getWeatherUseCase.execute(lat: K.Map.latParis, lng: K.Map.longParis)
        
        switch result {
        case .success(let temperature):
            DispatchQueue.main.async {
                self.weather = temperature
                self.weatherState = .loaded
            }
        case .failure:
            DispatchQueue.main.async {
                self.weatherState = .errorNetwork
            }
        }
    }
    
    func getTemperatureValue() -> String {
        String(format: "%.1f", weather) + " °C"
    }
    
    private func getAQData(_ forceRefresh: Bool = false) async {
        
        if !forceRefresh && aqiState == .loaded {
            return
        }
        
        DispatchQueue.main.async {
            self.aqiState = .loading
        }
        
        let result = await getAirQualityUseCase.execute(lat: self.latitude, lng: self.longitude)
        
        switch result {
        case .success(let aqi):
            DispatchQueue.main.async {
                self.airQuality = aqi
                self.aqiDescription = getAQDesc(id: aqi)
                self.aqiState = .loaded
            }
        case .failure:
            DispatchQueue.main.async {
                self.aqiState = .errorNetwork
            }
        }
    }
    
    func getAqiValue() -> String {
        aqiDescription
    }
}

private func getAQDesc(id: Int) -> String {
    switch id {
    case 1:
        return "Good"
    case 2:
        return "Fair"
    case 3:
        return "Moderate"
    case 4:
        return "Poor"
    case 5:
        return "Very Poor"
    default:
        return "cannotProcessData"
    }
}

