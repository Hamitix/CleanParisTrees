//
//  AirQuality.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 14/04/2022.
//

import Foundation

struct AirQualityResponse: Decodable {
    let status: String
    let data: AQData
}

struct AQData: Decodable {
    let aqIndex: Double
    
    enum CodingKeys: String, CodingKey {
        case aqIndex = "aqi"
    }
}
