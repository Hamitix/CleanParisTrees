//
//  ParisOpenDataAPI.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import Foundation

// MARK: ParisOpenDataAPI
class ParisOpenDataAPI : NSObject {
    
    private let url = URL(string: "\(K.OpenDataAPI.baseURL)\(K.OpenDataAPI.query)")!
    
    func apiGetTreesData(completion: @escaping (Trees) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response
            , error in
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                
                if  let treesData = try? jsonDecoder.decode(Trees.self, from: data) {
                    completion(treesData)
                }
                else  {
                    print("\(K.OpenDataAPI.errorDecodingData)\( String(describing: error))")
                }
            } else {
                print("\(K.OpenDataAPI.errorRetrievingData)\(String(describing: error))")
            }
        }.resume()
    }
}
