//
//  WeatherRepositoryImpl.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 25/04/2022.
//

import Foundation

struct WeatherRepositoryImpl: WeatherRepository {
    
    var dataSource: WeatherDataSource
    
    func getWeather(lat: Double, lng: Double) async throws -> Double {
        let _temperature = try await dataSource.getTemperature(lat: lat, lng: lng)
        return _temperature
    }
    
    func getAirQuality(lat: Double, lng: Double) async throws -> Int {
        let _aqi = try await dataSource.getAirQuality(lat: lat, lng: lng)
        return _aqi
    }
}
