//
//  LocalTreeDataSource.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 10/05/2022.
//

import Foundation

protocol LocalTreeDataSource {
    func getTreeListLocal(startRow: Int, isLazy: Bool) throws -> [GeolocatedTree]
}
