//
//  TreeRepositoryImpl.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 25/04/2022.
//

import Foundation

struct RemoteTreeRepositoryImpl: RemoteTreeRepository {
    
    var dataSource: RemoteTreeDataSource
    
    func getTreeList(startRow: Int, nbrRows: Int) async throws -> [GeolocatedTree] {
        try await dataSource.getTreeListRemote(startRow: startRow, nbrRows: nbrRows)
    }
}
