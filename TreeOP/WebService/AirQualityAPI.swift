//
//  AirQualityAPI.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 14/04/2022.
//

import Foundation

class AirQualityAPI: NSObject, WeatherDataService {
    func apiGetWeatherData(lat: Double, long: Double, completion: @escaping (Double) -> Void) {
        
        let url = URL(string: "\(K.AirQualityAPI.baseURL)\(lat);\(long)?token=\(K.AirQualityAPI.keyAPI)")!
        
        URLSession.shared.dataTask(with: url) { data, response
            , error in
            
            if let data = data {
                
                print("data : \(String(describing: data))")
                let jsonDecoder = JSONDecoder()
                
                if let aqResponse = try? jsonDecoder.decode(AirQualityResponse.self, from: data) {
                    completion(aqResponse.data.aqIndex)
                }
                else {
                    print("errorDecodingData \(String(describing: error))")
                }
            } else {
                print("errorRetrievingData \(String(describing: error))")
            }
        }.resume()
    }
}
