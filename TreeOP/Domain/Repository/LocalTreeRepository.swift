//
//  LocalTreeRepository.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 10/05/2022.
//

import Foundation

protocol LocalTreeRepository {
    func getTreeList(offset: Int) throws -> [GeolocatedTree]
}
