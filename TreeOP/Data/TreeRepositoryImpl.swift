//
//  TreeRepositoryImpl.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 25/04/2022.
//

import Foundation

struct TreeRepositoryImpl: TreeRepository {
    
    var dataSource: TreeDataSource
    
    func getTreeList(startRow: Int, nbrRows: Int) async throws -> [GeolocatedTree] {
        let trees = try await dataSource.getTreeList(startRow: startRow, nbrRows: nbrRows)
        return trees
    }
}
