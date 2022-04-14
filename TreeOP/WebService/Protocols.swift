//
//  ProtocolAPIs.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 14/04/2022.
//

import Foundation

// MARK: Protocol TreeDataService
protocol TreeDataService {
    func apiGetDataTrees(completion: @escaping ([RecordsData]) -> Void)
}


// MARK: Protocol WeatherDataService
protocol WeatherDataService {
    func apiGetWeatherData(lat: Double, long: Double, completion: @escaping (Double) -> Void)
}
