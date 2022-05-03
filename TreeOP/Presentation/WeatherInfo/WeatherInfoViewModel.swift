//
//  WeatherInfoViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 14/04/2022.
//

import Foundation

class WeatherInfoViewModel: ObservableObject {
    
    @Published var airQuality: Int = 0
    @Published var aqiDescription: String = ""
    @Published var weather: Double? = 0
    
    private let latitude: Double
    private let longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var getWeatherUseCase = GetWeatherUseCase(weatherRepo: WeatherRepositoryImpl(dataSource: WeatherAPIImpl()))
    
    var getAirQualityUseCase = GetAirQualityUseCase(weatherRepository: WeatherRepositoryImpl(dataSource: WeatherAPIImpl()))
    
    func getWeatherData() async {
        
        let result = await getWeatherUseCase.execute(lat: K.latParis, lng: K.longParis)
        
        switch result {
        case .success(let temperature):
            DispatchQueue.main.async {
                self.weather = temperature
            }
        case .failure(let error):
            DispatchQueue.main.async {
                print("Failure getWeatherData : \(error.localizedDescription)")
            }
        }
    }
    
    func getAQData() async {
        
        let result = await getAirQualityUseCase.execute(lat: self.latitude, lng: self.longitude)
        
        switch result {
        case .success(let aqi):
            DispatchQueue.main.async {
                self.airQuality = aqi
                self.aqiDescription = getAQDesc(id: aqi)
            }
        case .failure(let error):
            DispatchQueue.main.async {
                print("Failure getAQData : \(error.localizedDescription)")
            }
        }
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

