//
//  ParisOpenDataAPI.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import Foundation

class ParisOpenDataAPI : NSObject, TreeDataService {
  
    func apiGetDataTrees(startRow: Int, nbrRows: Int, completion: @escaping (Result<[RecordsData], ErrorAPI>) -> ()) {
        
        let url = String(localized: "urlOpenDataURL \(nbrRows) \(startRow)")
        
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
