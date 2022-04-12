//
//  ParisOpenDataAPI.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import Foundation


// MARK: Protocol DataService
protocol DataService {
    func apiGetDataTrees(completion: @escaping ([RecordsData]) -> Void)
}

// MARK: ParisOpenDataAPI
class ParisOpenDataAPI : NSObject, DataService {
    
    private let url = URL(string: "\(K.OpenDataAPI.baseURL)\(K.OpenDataAPI.query)")!
    
    func apiGetDataTrees(completion: @escaping ([RecordsData]) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response
            , error in
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                
                if let trees = try? jsonDecoder.decode(Trees.self, from: data) {
                    completion(trees.records)
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
