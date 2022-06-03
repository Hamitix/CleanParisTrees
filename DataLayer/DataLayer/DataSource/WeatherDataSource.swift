//
//  WeatherDataSource.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 22/04/2022.
//

import Foundation

import APILayer

public protocol WeatherDataSource {
    func getTemperature(lat: Double, lng: Double) async throws -> Double
    func getAirQuality(lat: Double, lng: Double) async throws -> Int
}
