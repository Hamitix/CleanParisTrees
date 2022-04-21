//
//  AirInfoViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 14/04/2022.
//

import Foundation

class InfosViewModel: ObservableObject {
    
    @Published var airQuality: Int = 0
    @Published var aqiDescription: String = ""
    @Published var weather: Double? = 0
    
    private let latitude: Double
    private let longitude: Double
    private let weatherDataService: WeatherDataService
    
    init(latitude: Double, longitude: Double, weatherDataService: WeatherDataService = WeatherAPI()) {
        self.weatherDataService = weatherDataService
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getWeatherData() {
        weatherDataService.getWeatherData(lat: self.latitude, long: self.longitude) { (responseWeather: Result<Double, ErrorAPI>) in
            
            switch responseWeather {
            case .success(let temperature):
                DispatchQueue.main.async {
                    self.weather = temperature
                }
            case .failure(let error):
                Network.printErrorAPI(error: error)
                
                DispatchQueue.main.async {
                    self.weather = nil
                }
            }
        }
    }
    
    func getAQData() {
        weatherDataService.getAirQualityData(lat: self.latitude, long: self.longitude) { (responseAQI: Result<Int, ErrorAPI>) in
            
            switch responseAQI {
                
            case .success(let aqi):
                DispatchQueue.main.async {
                    self.airQuality = aqi
                    self.aqiDescription = self.getAQDesc(id: aqi)
                }
                
            case .failure(let error):
                Network.printErrorAPI(error: error)
                
                DispatchQueue.main.async {
                    self.airQuality = 0
                    self.aqiDescription = self.getAQDesc(id: 0)
                }
            }
        }
    }
    
    func getAQDesc(id: Int) -> String {
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
            return "Couldn't process data"
        }
    }
}

