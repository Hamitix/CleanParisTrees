//
//  Tree.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import Foundation

struct Trees: Decodable {
    let records: [RecordData]
}

struct RecordData: Decodable {
    let fields: TreeData
}

struct TreeData: Decodable {
    let name, species, adress: String
    let height, circumference: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "libellefrancais"
        case species = "espece"
        case height = "hauteurenm"
        case adress = "adresse"
        case circumference = "circonferenceencm"
    }
}
