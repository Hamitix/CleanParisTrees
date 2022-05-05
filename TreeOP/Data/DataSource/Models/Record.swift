//
//  Tree.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import Foundation

struct Records: Decodable {
    let nhits: Int
    let records: [RecordData]
}

struct RecordData: Decodable, Identifiable, Hashable {
    let recordid: String
    let fields: Record
    let geometry: Geometry
    
    var id: String {
        recordid
    }
}

struct Record: Decodable, Hashable {
    let name, species, address2: String?
    let address: String
    let height, circumference, id: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "libellefrancais"
        case species = "espece"
        case address2 = "complementadresse"
        case address = "adresse"
        case height = "hauteurenm"
        case circumference = "circonferenceencm"
        case id = "idbase"
    }
}

struct Geometry: Decodable, Hashable {
    let type: String
    let coordinates: [Double]
}
