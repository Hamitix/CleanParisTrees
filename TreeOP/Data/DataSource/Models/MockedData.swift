//
//  MockedData.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 04/05/2022.
//

import Foundation

extension Geometry {
    static let sampleData = Geometry(type: "Point", coordinates: [
        2.349718604917588,
        48.89082227307561
    ])
}

extension Record {
    static let sampleData = Record(name: "Pommier",  species: "trilobata", address2: "85", address: "Rue Victor Hugo", height: 12, circumference: 12, id: 23)
}

extension RecordData {
    static let sampleData = RecordData(recordid: "0"
                                        , fields: Record.sampleData
                                        , geometry: Geometry.sampleData
    )
}

extension MainWeather {
    static let sampleData = MainWeather(temperature: 19)
}

extension Weather {
    static let sampleData = Weather(id: 100, main: "Main" , description: "Sunny")
}

extension MainAQI {
    static let sampleData = MainAQI(aqi: 1)
}

extension AQData {
    static let sampleData = AQData(main: MainAQI.sampleData)
}
