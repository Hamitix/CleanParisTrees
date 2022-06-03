//
//  LocalTreeRepository.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 10/05/2022.
//

import Foundation

public protocol LocalTreeRepository {
    func getTreeList(startRow: Int, isLazy: Bool) throws -> [GeolocatedTree]
}
