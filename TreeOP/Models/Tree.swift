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
    let geometry: Geometry
    
    var id: String {
        recordid
    }
}

struct Tree: Decodable, Hashable {
    let name, species, address2: String?
    let address, arrdt : String
    let height, circumference, id: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "libellefrancais"
        case species = "espece"
        case address2 = "complementadresse"
        case address = "adresse"
        case arrdt = "arrondissement"
        case height = "hauteurenm"
        case circumference = "circonferenceencm"
        case id = "idbase"
    }
}

struct Geometry: Decodable, Hashable {
    let type: String
    let coordinates: [Double]
}

extension Geometry {
    static let sampleData = Geometry(type: "Point", coordinates: [
        2.349718604917588,
        48.89082227307561
    ])
}

extension Tree {
    static let sampleData = Tree(name: "Pommier",  species: "trilobata", address2: "85", address: "Rue Victor Hugo", arrdt: "PARIS 18E ARRDT", height: 12, circumference: 12, id: 23)
}

extension RecordsData {
    static let sampleData = RecordsData(recordid: "0"
                                        , fields: Tree.sampleData
                                        , geometry: Geometry.sampleData
    )
}

