//
//  GeolocatedTree.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 22/04/2022.
//

import Foundation

public struct GeolocatedTree: Identifiable {
    public let tree: Tree
    public let lng: Double
    public let lat: Double
    public var id: Int {
        tree.id
    }
    
    public init(tree: Tree, lng: Double, lat: Double) {
        self.tree = tree
        self.lat = lat
        self.lng = lng
    }
}


extension GeolocatedTree : Equatable {
    static public func == (lhs: GeolocatedTree, rhs: GeolocatedTree) -> Bool {
        lhs.id == rhs.id
    }
}
