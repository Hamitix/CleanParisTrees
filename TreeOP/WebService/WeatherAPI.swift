//
//  WeatherAPI.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 14/04/2022.
//

import Foundation

class WeatherAPI: NSObject, WeatherDataService {
    
    func apiGetWeatherData(lat: Double, long: Double, completion: @escaping (Double) -> Void) {
        
        let url = URL(string: "\(K.WeatherAPI.baseURL)lat=\(lat)&lon=\(long)&appid=\(K.WeatherAPI.keyAPI)&units=metric")!
        
        URLSession.shared.dataTask(with: url) { data, response
            , error in
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                
                if let weatherData = try? jsonDecoder.decode(WeatherResponse.self, from: data) {
                    completion(weatherData.main.temperature)
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
