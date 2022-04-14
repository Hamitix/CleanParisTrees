//
//  AirInfoViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 14/04/2022.
//

import Foundation

class InfosViewModel: ObservableObject {
    
    @Published var airQuality: Double = 0
    @Published var aqiDescription: String = ""
    @Published var weather: Double = 0
    
    private let latitude: Double
    private let longitude: Double
    private let weatherDataService: WeatherDataService
    private let aqDataService: WeatherDataService
    
    
    init(latitude: Double, longitude: Double, weatherDataService: WeatherDataService = WeatherAPI(), aqDataService: WeatherDataService = AirQualityAPI()) {
        self.weatherDataService = weatherDataService
        self.aqDataService = aqDataService
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getWeatherData() {
        weatherDataService.apiGetWeatherData(lat: self.latitude, long: self.longitude) { weatherData in
            DispatchQueue.main.async {
                self.weather = weatherData
            }
        }
    }
    
    func getAQData() {
        aqDataService.apiGetWeatherData(lat: self.latitude, long: self.longitude) { aqData in
            DispatchQueue.main.async {
                self.airQuality = aqData
                self.aqiDescription = self.getAQDesc(id: aqData)
            }
        }
    }
    
    
    func getAQDesc(id: Double) -> String {
        switch id {
            case 0...50:
                return "Good"
            case 51...100:
                return "Moderate"
            case 101...150:
                return "Unhealthy for sensitive groups"
            case 151...200:
                return "Unhealthy"
            case 201...300:
                return "Very unhealthy"
            case 300...Double.infinity:
                return "Hazardous"
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

