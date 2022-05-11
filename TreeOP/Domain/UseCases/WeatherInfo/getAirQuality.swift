//
//  getAirQuality.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 22/04/2022.
//

import Foundation

protocol getAirQuality {
    func execute(lat: Double, lng: Double) async -> Result<Int, UseCaseError>
}

struct GetAirQualityUseCase: getAirQuality {
    
    let networkManager = NetworkMonitor.shared
    
    var weatherRepository: WeatherRepository
    
    func execute(lat: Double, lng: Double) async -> Result<Int, UseCaseError> {
        
        switch networkManager.fetchStrategy {
            
        case .local:
            return .failure(.networkError)
        case .remote:
            do {
                let airQualityIndex = try await weatherRepository.getAirQuality(lat: lat, lng: lng)
                return .success(airQualityIndex)
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
