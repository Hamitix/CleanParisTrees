//
//  GetWeatherUseCase.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 22/04/2022.
//

import Foundation
import Resolver

import APILayer

public protocol GetWeather {
    func execute(lat: Double, lng: Double, fetchStrategy: FetchStrategy) async -> Result<Double, UseCaseError>
}

public struct GetWeatherUseCase: GetWeather {
        
    @Injected var repository: WeatherRepository
    
    
    public init() {}
    
    public func execute(lat: Double, lng: Double, fetchStrategy: FetchStrategy) async -> Result<Double, UseCaseError> {
        switch fetchStrategy {
            
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
