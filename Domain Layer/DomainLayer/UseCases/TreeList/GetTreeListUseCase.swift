//
//  getTreeList.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 22/04/2022.
//

import Foundation
import Resolver

import APILayer

public protocol GetTreeList {
    func fetch(startRow: Int, isLazy: Bool, fetchStrategy: FetchStrategy) async -> Result<[GeolocatedTree], UseCaseError>
}

public struct GetTreeListUseCase: GetTreeList {

    @Injected var localTreeRepo: LocalTreeRepository
    @Injected var remoteTreeRepo: RemoteTreeRepository
    
    let nbRowToRetrieveInLazy: Int = 20
    
    public init() {}
    
    public func fetch(startRow: Int, isLazy: Bool = true, fetchStrategy: FetchStrategy) async -> Result<[GeolocatedTree], UseCaseError> {
        
        switch fetchStrategy {
            
        case .remote:
            
            do {
                let treeList = try await remoteTreeRepo.getTreeList(startRow: startRow, nbRows: nbRowToRetrieveInLazy)
                
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
            
            do {
                let trees = try localTreeRepo.getTreeList(startRow: startRow, isLazy: isLazy)
                return .success(trees)
                
            } catch {
                return .failure(UseCaseError.retrievingFromDBError)
            }
        }
    }
}
