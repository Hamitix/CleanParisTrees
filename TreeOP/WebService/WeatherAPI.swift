//
//  WeatherAPI.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 14/04/2022.
//

import Foundation

class WeatherAPI: NSObject, WeatherDataService {
    
    func genericRequest<T: Decodable>(stringURL: String, completion: @escaping (T) -> Void ) {
        
        let url = URL(string: stringURL)!
        
        URLSession.shared.dataTask(with: url) { data, response
            , error in
            
            if let data = data {

                if let response = try?  JSONDecoder().decode(T.self, from: data) {
                    completion(response)
                    
                }     else {
                    print("errorDecodingData \(String(describing: error))")
                }
            } else {
                print("errorRetrievingData \(String(describing: error))")
            }
        }.resume()
    }
    
    
    func getWeatherData(lat: Double, long: Double, completion: @escaping (Double) -> Void) {
        
        let url =  "\(K.WeatherAPI.baseURL)lat=\(lat)&lon=\(long)&appid=\(K.WeatherAPI.keyAPI)&units=metric"
        
        self.genericRequest(stringURL: url) { (res: WeatherResponse) in
            DispatchQueue.main.async {
                completion(res.main.temperature)
            }
        }
    }
    
    func getAirQualityData(lat: Double, long: Double, completion: @escaping (Int) -> Void) {
        
        let url: String = "\(K.AirQualityAPI.baseURL)\(lat);\(long)?token=\(K.AirQualityAPI.keyAPI)"
        
        self.genericRequest(stringURL: url) { (res: AirQualityResponse) in
            DispatchQueue.main.async {
                completion(res.data.aqIndex)
            }
        }
    }
}
