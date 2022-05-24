//
//  MockedDataDomain.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 04/05/2022.
//

import Foundation

extension Tree {
    static let sampleData = Tree(name: "Pommier",  species: "trilobata", address: "Rue Victor Hugo", address2: "85", height: 12, circumference: 12, id: 23)
}

extension GeolocatedTree {
    static let sampleGLTree = GeolocatedTree(tree: Tree.sampleData, lng: 2.380276792214754, lat: 48.87979863300749)
}

