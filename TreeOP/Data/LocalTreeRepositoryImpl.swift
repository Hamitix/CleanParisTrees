//
//  LocalTreeRepositoryImpl.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 10/05/2022.
//

import Foundation
import Resolver

struct LocalTreeRepositoryImpl: LocalTreeRepository {
    
    @Injected var dataSource: LocalTreeDataSource
    
    func getTreeList(startRow: Int, isLazy: Bool) throws -> [GeolocatedTree] {
        try dataSource.getTreeListLocal(startRow: startRow, isLazy: isLazy)
    }
}
