//
//  getTreeList.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 22/04/2022.
//

import Foundation
import Resolver

protocol GetTreeList {
    func fetch(startRow: Int, isLazy: Bool, fetchStrategy: FetchStrategy) async -> Result<[GeolocatedTree], UseCaseError>
}

struct GetTreeListUseCase: GetTreeList {

    @Injected var localTreeRepo: LocalTreeRepository
    @Injected var remoteTreeRepo: RemoteTreeRepository
    
    func fetch(startRow: Int, isLazy: Bool = true, fetchStrategy: FetchStrategy) async -> Result<[GeolocatedTree], UseCaseError> {
        
        switch fetchStrategy {
            
        case .remote:
            //return await GetTreeListRemote().fetch(startRow: startRow, isLazy: isLazy)
            do {
                let treeList = try await remoteTreeRepo.getTreeList(startRow: startRow, nbRows: K.OpenDataAPI.nbRowPerRequest)
                
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
            
        case .local:
            //return GetTreeListLocal().fetch(startRow: startRow, isLazy: isLazy)
            do {
                let trees = try localTreeRepo.getTreeList(startRow: startRow, isLazy: isLazy)
                return .success(trees)
                
            } catch {
                return .failure(UseCaseError.retrievingFromDBError)
            }
        }
    }
}
