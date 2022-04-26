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


//
//extension Geometry {
//    static let sampleData = Geometry(type: "Point", coordinates: [
//        2.349718604917588,
//        48.89082227307561
//    ])
//}
//
//extension Record {
//    static let sampleData = Record(name: "Pommier",  species: "trilobata", address2: "85", address: "Rue Victor Hugo", height: 12, circumference: 12, id: 23)
//}
//
//extension RecordData {
//    static let sampleData = RecordData(recordid: "0"
//                                        , fields: Record.sampleData
//                                        , geometry: Geometry.sampleData
//    )
//}

