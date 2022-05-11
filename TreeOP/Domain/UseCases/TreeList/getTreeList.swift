//
//  getTreeList.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 22/04/2022.
//

import Foundation
import Network

protocol getTreeList {
    func fetch(startRow: Int) async -> Result<[GeolocatedTree], UseCaseError>
}

struct GetTreeListUseCase: getTreeList {
    let networkManager = NetworkMonitor.shared
    
    func fetch(startRow: Int) async -> Result<[GeolocatedTree], UseCaseError> {
        
        switch networkManager.fetchStrategy {
            
        case .remote:
            
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
            
        case .local:
            
            let localTreeRepo = LocalTreeRepositoryImpl(dataSource: TreeDBImpl())
            
            do {
                let trees = try localTreeRepo.getTreeList()
                return .success(trees)
                
            } catch {
                return .failure(UseCaseError.retrievingFromDBError)
            }
        }
    }
}
