//
//  getTreeList.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 22/04/2022.
//

import Foundation

protocol getTreeList {
    func execute(startRow: Int) async -> Result<[GeolocatedTree], UseCaseError>
}

struct GetTreeListUseCase: getTreeList {
    
    var treeRepository: TreeRepository
    
    func execute(startRow: Int) async -> Result<[GeolocatedTree], UseCaseError> {
        do {
            let treeList = try await treeRepository.getTreeList(startRow: startRow, nbrRows: K.OpenDataAPI.nbrRowPerRequest)
            return .success(treeList)
        } catch (let error) {
            
            switch error {
                
            case APIServiceError.decodingError:
                return .failure(.decodingError)
                
            default:
                return .failure(.networkError)
            }
        }
    }
}
