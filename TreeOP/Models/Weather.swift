//
//  Weather.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 14/04/2022.
//

import Foundation


struct WeatherResponse: Decodable {
    let weather: [Weather]
    let main: Main
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
}

struct Main: Decodable {
    let temperature: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
    }
}
