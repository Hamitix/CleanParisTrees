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

struct RecordsData: Decodable, Identifiable {
    let recordid: String
    let fields: Tree
    
    var id: String {
        recordid
       }
}

struct Tree: Decodable {
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
