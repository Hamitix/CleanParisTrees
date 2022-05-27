//
//  TreeRepositoryImpl.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 25/04/2022.
//

import Foundation
import Resolver

struct RemoteTreeRepositoryImpl: RemoteTreeRepository {
    
    @Injected var dataSource: RemoteTreeDataSource
    
    func getTreeList(startRow: Int, nbRows: Int) async throws -> [GeolocatedTree] {
        try await dataSource.getTreeListRemote(startRow: startRow, nbRows: nbRows)
    }
}
