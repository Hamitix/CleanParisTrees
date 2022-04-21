//
//  ParisOpenDataAPI.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import Foundation

class ParisOpenDataAPI : NSObject, TreeDataService {
  
    func apiGetDataTrees(startRow: Int, completion: @escaping (Result<[RecordsData], ErrorAPI>) -> ()) {
        let url = "\(K.OpenDataAPI.baseURL)\(K.OpenDataAPI.baseQuery)&rows=\(K.OpenDataAPI.nbrRowPerRequest)&start=\(startRow)\(K.OpenDataAPI.facet)"
        
        Network.genericRequest(stringURL: url) { (response: Result<Trees,ErrorAPI>) in
            
            switch response {
            case .success(let trees):
                completion(.success(trees.records))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
