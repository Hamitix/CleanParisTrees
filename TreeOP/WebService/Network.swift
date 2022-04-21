//
//  Generics Methods.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 21/04/2022.
//

import Foundation


// MARK: Protocol TreeDataService
protocol TreeDataService {
    func apiGetDataTrees(startRow: Int, nbrRows: Int, completion: @escaping (Result<[RecordsData], ErrorAPI>) -> Void)
}


// MARK: Protocol WeatherDataService
protocol WeatherDataService {
    func getWeatherData(lat: Double, long: Double, completion: @escaping (Result<Double, ErrorAPI>) -> Void)
    
    func getAirQualityData(lat: Double, long: Double, completion: @escaping (Result<Int, ErrorAPI>) -> Void)
}

// MARK: Enum ErrorAPI
enum ErrorAPI : Error {
    case badURL
    case dataNotDecodable
    case dataNotRetrievable
    case unknown
}

//MARK: Class Network
class Network: NSObject {
    
    static func genericRequest<T: Decodable>(stringURL: String, completion: @escaping (Result<T, ErrorAPI>) -> Void ) {
        
        guard let url = URL(string: stringURL) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response
            , error in
            
            guard let data = data else {
                completion(.failure(.dataNotRetrievable))
                return
            }
            
            if let response = try? JSONDecoder().decode(T.self, from: data) {
                completion(.success(response))
            } else {
                completion(.failure(.dataNotDecodable))
            }
        }.resume()
    }
    
    static func printErrorAPI(error: ErrorAPI) {
        switch error {
        case .dataNotDecodable:
            print(String(localized: "errorDecodingData"))
            
        case .dataNotRetrievable:
            print(String(localized: "errorRetrievingData"))
            
        case .badURL:
            print(String(localized: "errorBadURL"))
            
        case .unknown:
            print(String(localized: "errorUnknown"))
        }
    }
}
