//
//  MockedData.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 27/05/2022.
//

import Foundation

extension Tree {
    static let mock = Tree(name: "Pommier",  species: "trilobata", address: "Rue Victor Hugo", address2: "85", height: 12, circumference: 12, id: 23)
}

extension GeolocatedTree {
    static let mock = GeolocatedTree(tree: Tree.mock, lng: 2.380276792214754, lat: 48.87979863300749)
}

