//
//  WeatherAPIImpl.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 22/04/2022.
//

import Foundation

struct WeatherAPIImpl: WeatherDataSource {
    
    func getTemperature(lat: Double, lng: Double) async throws -> Double {
        
        guard let url = URL(string: String(localized: "temperatureURL \(lat.description) \(lng.description)")) else {
            throw APIServiceError.badUrl
        }
                
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw APIServiceError.requestError
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIServiceError.statusNotOK
        }
        
        guard let result = try? JSONDecoder().decode(WeatherResponse.self, from: data) else {
            throw APIServiceError.decodingError
        }
        return result.main.temperature
    }
    
    
    func getAirQuality(lat: Double, lng: Double) async throws -> Int {
        
        guard let url = URL(string: String(localized: "aqiURL \(lat.description) \(lng.description)")) else {
            throw APIServiceError.badUrl
        }
            
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw APIServiceError.requestError
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIServiceError.requestError
        }
        
        guard let result = try? JSONDecoder().decode(AirQualityResponse.self, from: data) else {
            throw APIServiceError.decodingError
        }

        return result.data.first?.main.aqi ?? 0
    }
}

