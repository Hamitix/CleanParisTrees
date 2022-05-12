//
//  getWeather.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 22/04/2022.
//

import Foundation


protocol getWeather {
    func execute(lat: Double, lng: Double) async -> Result<Double, UseCaseError>
}

struct GetWeatherUseCase: getWeather {
    
    let networkManager = NetworkMonitor.shared
    
    var weatherRepo: WeatherRepository
    
    func execute(lat: Double, lng: Double) async -> Result<Double, UseCaseError> {
        switch networkManager.fetchStrategy {
            
        case .local:
            return .failure(.networkError)
            
        case .remote:
            do {
                let temperature = try await weatherRepo.getWeather(lat: lat, lng: lng)
                return .success(temperature)
            } catch (let error) {
                switch error {
                case APIServiceError.decodingError:
                    return .failure(.decodingError)
                    
                default:
                    return .failure(.networkError)
                }
            }
        }
    }
}
