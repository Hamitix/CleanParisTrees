//
//  WeatherRepository.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 25/04/2022.
//

import Foundation

protocol WeatherRepository {
    func getWeather(lat: Double, lng: Double) async throws -> Double
    func getAirQuality(lat: Double, lng: Double) async throws -> Int
}
