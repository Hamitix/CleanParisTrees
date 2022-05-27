//
//  GetAirQualityUseCase.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 22/04/2022.
//

import Foundation
import Resolver

protocol GetAirQuality {
    func execute(lat: Double, lng: Double) async -> Result<Int, UseCaseError>
}

struct GetAirQualityUseCase: GetAirQuality {
    
    @Injected var networkMonitor: NetworkMonitor
    
    @Injected var repository: WeatherRepository
    
    func execute(lat: Double, lng: Double) async -> Result<Int, UseCaseError> {
        
        switch networkMonitor.fetchStrategy {
            
        case .local:
            return .failure(.networkError)
        case .remote:
            do {
                let airQualityIndex = try await repository.getAirQuality(lat: lat, lng: lng)
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
