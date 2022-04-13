//
//  Tree.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import Foundation

struct Trees: Decodable {
    let nhits: Int
    let records: [RecordsData]
}

struct RecordsData: Decodable, Identifiable, Hashable {
    let recordid: String
    let fields: Tree
    
    var id: String {
        recordid
    }
}

struct Tree: Decodable, Hashable {
    let name, species, address, address2: String
    let height, circumference: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "libellefrancais"
        case species = "espece"
        case height = "hauteurenm"
        case address = "adresse"
        case address2 = "arrondissement"
        case circumference = "circonferenceencm"
    }
}

extension Tree {
    static let sampleData = Tree(name: "Pommier", species: "trilobata", address: "Rue Victor Hugo", address2: "PARIS 20 ARRDT ", height: 5, circumference:  34)
}

extension RecordsData {
    static let sampleData = RecordsData(recordid: "0", fields: Tree.sampleData)
}
