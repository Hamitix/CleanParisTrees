//
//  ParisOpenDataAPI.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import Foundation

class ParisOpenDataAPI : NSObject, TreeDataService {
  
    func apiGetDataTrees(startRow: Int, completion: @escaping ([RecordsData]) -> ()) {
        let url = URL(string: "\(K.OpenDataAPI.baseURL)\(K.OpenDataAPI.baseQuery)&start=\(startRow)\(K.OpenDataAPI.facet)")!
        
        URLSession.shared.dataTask(with: url) { data, response
            , error in
            
            if let data = data {
                                
                if let trees = try? JSONDecoder().decode(Trees.self, from: data) {
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
