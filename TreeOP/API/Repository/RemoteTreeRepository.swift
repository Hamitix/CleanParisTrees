//
//  TreeRepository.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 25/04/2022.
//

import Foundation

protocol RemoteTreeRepository {
    func getTreeList(startRow: Int, nbrRows: Int) async throws -> [GeolocatedTree]
}

