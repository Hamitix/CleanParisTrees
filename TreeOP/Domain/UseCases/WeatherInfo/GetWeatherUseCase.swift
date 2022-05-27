//
//  GetWeatherUseCase.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 22/04/2022.
//

import Foundation
import Resolver


protocol GetWeather {
    func execute(lat: Double, lng: Double) async -> Result<Double, UseCaseError>
}

struct GetWeatherUseCase: GetWeather {
    
    @Injected var networkMonitor: NetworkMonitor
    
    @Injected var repository: WeatherRepository
    
    func execute(lat: Double, lng: Double) async -> Result<Double, UseCaseError> {
        switch networkMonitor.fetchStrategy {
            
        case .local:
            return .failure(.networkError)
            
        case .remote:
            do {
                let temperature = try await repository.getWeather(lat: lat, lng: lng)
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
