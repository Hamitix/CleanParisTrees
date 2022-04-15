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
    @Published var weather: Double = 0
    
    private let latitude: Double
    private let longitude: Double
    private let weatherDataService: WeatherDataService
    
    
    init(latitude: Double, longitude: Double, weatherDataService: WeatherDataService = WeatherAPI()) {
        self.weatherDataService = weatherDataService
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getWeatherData() {
        weatherDataService.getWeatherData(lat: self.latitude, long: self.longitude) { weatherData in
            DispatchQueue.main.async {
                self.weather = weatherData
            }
        }
    }
    
    func getAQData() {
        weatherDataService.getAirQualityData(lat: self.latitude, long: self.longitude) { aqData in
            DispatchQueue.main.async {
                self.airQuality = aqData
                self.aqiDescription = self.getAQDesc(id: aqData)
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
    
    func getWeatherIconName(aqi: Int) -> String {
        switch aqi {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud-drizzle"
        case 500...531:
            return "cloud-rain"
        case 600...622:
            return "cloud-snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun-max"
        default:
            return "cloud"
        }
    }
}

