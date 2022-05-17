//
//  getTreeListRemote.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 16/05/2022.
//

import Foundation


struct GetTreeListRemote: getTreeList {
    
    func fetch(startRow: Int, isLazy: Bool) async -> Result<[GeolocatedTree], UseCaseError> {
        let remoteTreeRepo = RemoteTreeRepositoryImpl(dataSource: TreeAPIImpl())
        
        do {
            let treeList = try await remoteTreeRepo.getTreeList(startRow: startRow, nbrRows: K.OpenDataAPI.nbrRowPerRequest)
            
            if startRow == 0 {
                CoreDataController.shared.deleteAllTreesInContext()
            }
            
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
