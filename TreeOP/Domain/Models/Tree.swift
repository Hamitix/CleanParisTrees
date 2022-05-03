//
//  Tree.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 22/04/2022.
//

import Foundation

struct Tree {
    let name: String?
    let species: String?
    let address: String
    let address2: String?
    let height: Int
    let circumference: Int
    let id: Int
}

extension Record: DataToDomain {
    func ToDomain() -> Tree {
        Tree(name: name,
             species: species,
             address: address,
             address2: address2,
             height: height,
             circumference: circumference,
             id: id)
    }
}


extension Tree {
    static let sampleData = Tree(name: "Pommier",  species: "trilobata", address: "Rue Victor Hugo", address2: "85", height: 12, circumference: 12, id: 23)
}