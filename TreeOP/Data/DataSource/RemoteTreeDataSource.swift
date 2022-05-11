//
//  TreeDataSource.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 22/04/2022.
//

import Foundation

protocol RemoteTreeDataSource {
    func getTreeListRemote(startRow: Int, nbrRows: Int) async throws -> [GeolocatedTree]
}
