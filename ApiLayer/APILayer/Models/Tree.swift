//
//  Tree.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 22/04/2022.
//

import Foundation

public struct Tree {
    public let id: Int
    public let name: String?
    public let species: String?
    public let address: String
    public let address2: String?
    public let height: Int
    public let circumference: Int
    
    public init(id: Int, name: String?, species: String?, address: String, address2: String?, height: Int, circumference: Int) {
        self.id = id
        self.name = name
        self.species = species
        self.address = address
        self.address2 = address2
        self.height = height
        self.circumference = circumference
    }
}


