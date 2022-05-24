//
//  AirQuality.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 14/04/2022.
//

import Foundation

struct AirQualityResponse: Decodable {
    let data: [AQData]
    
    enum CodingKeys: String, CodingKey {
        case data = "list"
    }
}

struct AQData: Decodable {
    let main: MainAQI
}

struct MainAQI: Decodable {
    let aqi: Int
}
