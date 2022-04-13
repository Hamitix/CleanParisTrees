//
//  Tree.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import Foundation
import MapKit

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

struct Geometry: Decodable, Hashable {
    let type: String
    let coordinates: [Double]
    
    var coordinateCL: CLLocationCoordinate2D {
        switch coordinates.count {
            
        case Int.min...1:
            return CLLocationCoordinate2D()

        default: return  CLLocationCoordinate2D(latitude: self.coordinates[1], longitude: self.coordinates[0])
        }
    }
}

extension Geometry {
    static let sampleData = Geometry(type: "Point", coordinates: [
        2.349718604917588,
        48.89082227307561
    ])
}


extension Tree {
    static let sampleData = Tree(name: "Pommier", species: "trilobata", address: "Rue Victor Hugo", address2: "PARIS 20 ARRDT ", height: 5, circumference:  34)
}

extension RecordsData {
    static let sampleData = RecordsData(recordid: "0", fields: Tree.sampleData, geometry: Geometry.sampleData)
}
