//
//  GeolocatedTree.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 22/04/2022.
//

import Foundation

struct GeolocatedTree: Identifiable {
    let tree: Tree
    let lng: Double
    let lat: Double
    var id: Int {
        tree.id
    }
}


extension GeolocatedTree : Equatable {
    static func == (lhs: GeolocatedTree, rhs: GeolocatedTree) -> Bool {
        lhs.id == rhs.id
    }
}
