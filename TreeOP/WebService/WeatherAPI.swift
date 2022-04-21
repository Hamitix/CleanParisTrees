//
//  WeatherAPI.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 14/04/2022.
//

import Foundation

class WeatherAPI: NSObject, WeatherDataService {
        
    func getWeatherData(lat: Double, long: Double, completion: @escaping (Result<Double, ErrorAPI>) -> Void) {
        
        let url = String(localized: "temperatureURL \(lat.description) \(long.description)")
        
        Network.genericRequest(stringURL: url) { (response: Result<WeatherResponse, ErrorAPI>)  in
            
            switch response {
            case .success(let weatherRes):
                DispatchQueue.main.async {
                    completion(.success(weatherRes.main.temperature))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAirQualityData(lat: Double, long: Double, completion: @escaping (Result<Int, ErrorAPI>) -> Void) {
        
        let url = String(localized: "aqiURL \(lat.description) \(long.description)")
        
        Network.genericRequest(stringURL: url) { (response: Result<AirQualityResponse, ErrorAPI>) in
            
            switch response {
            case .success(let aqiRes):
                DispatchQueue.main.async {
                    completion(.success(aqiRes.data.first?.main.aqi ?? 0))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
