//
//  GetAirQualityUseCase.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 22/04/2022.
//

import Foundation
import Resolver

import APILayer

public protocol GetAirQuality {
    func execute(lat: Double, lng: Double, fetchStrategy: FetchStrategy) async -> Result<Int, UseCaseError>
}

public struct GetAirQualityUseCase: GetAirQuality {
        
    @Injected var repository: WeatherRepository
    
    public init() {}
    
    public func execute(lat: Double, lng: Double, fetchStrategy: FetchStrategy) async -> Result<Int, UseCaseError> {
        
        switch fetchStrategy {
            
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
