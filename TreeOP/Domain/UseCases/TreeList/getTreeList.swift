//
//  getTreeList.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 22/04/2022.
//

import Foundation
import Network

protocol getTreeList {
    func fetch(startRow: Int, isLazy: Bool) async -> Result<[GeolocatedTree], UseCaseError>
}

struct GetTreeListUseCase: getTreeList {
    let networkManager = NetworkMonitor.shared
    
    func fetch(startRow: Int, isLazy: Bool = true) async -> Result<[GeolocatedTree], UseCaseError> {
        
        switch networkManager.fetchStrategy {
            
        case .remote:
            return await GetTreeListRemote().fetch(startRow: startRow, isLazy: isLazy)
            
        case .local:
            return GetTreeListLocal().fetch(startRow: startRow, isLazy: isLazy)
        }
    }
}
