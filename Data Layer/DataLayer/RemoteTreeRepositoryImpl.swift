//
//  TreeRepositoryImpl.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 25/04/2022.
//

import Foundation
import Resolver

import APILayer

public struct RemoteTreeRepositoryImpl: RemoteTreeRepository {
    
    @Injected var dataSource: RemoteTreeDataSource
    
    public init() { }
    
    public func getTreeList(startRow: Int, nbRows: Int) async throws -> [GeolocatedTree] {
        try await dataSource.getTreeListRemote(startRow: startRow, nbRows: nbRows)
    }
}
