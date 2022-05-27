//
//  TreeRepository.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 25/04/2022.
//

import Foundation

protocol RemoteTreeRepository {
    func getTreeList(startRow: Int, nbRows: Int) async throws -> [GeolocatedTree]
}
