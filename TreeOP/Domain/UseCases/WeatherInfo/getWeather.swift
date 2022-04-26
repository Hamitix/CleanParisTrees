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
    
    var weatherRepo: WeatherRepository
    
    func execute(lat: Double, lng: Double) async -> Result<Double, UseCaseError> {
        
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
