//
//  LocalTreeRepositoryImpl.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 10/05/2022.
//

import Foundation
import Resolver

import APILayer

public struct LocalTreeRepositoryImpl: LocalTreeRepository {
    
    @Injected var dataSource: LocalTreeDataSource
    
    public init() { }
    
    public func getTreeList(startRow: Int, isLazy: Bool) throws -> [GeolocatedTree] {
        try dataSource.getTreeListLocal(startRow: startRow, isLazy: isLazy)
    }
}
