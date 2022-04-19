//
//  ProtocolAPIs.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 14/04/2022.
//

import Foundation

// MARK: Protocol TreeDataService
protocol TreeDataService {
    func apiGetDataTrees(startRow: Int,completion: @escaping ([RecordsData]) -> Void)
}


// MARK: Protocol WeatherDataService
protocol WeatherDataService {
    func getWeatherData(lat: Double, long: Double, completion: @escaping (Double) -> Void)
    
    func getAirQualityData(lat: Double, long: Double, completion: @escaping (Int) -> Void)
}
