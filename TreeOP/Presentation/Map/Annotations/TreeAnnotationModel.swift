//
//  TreeAnnotationModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 20/05/2022.
//

import Foundation
import MapKit

import APILayer

final class TreeAnnotation: NSObject, MKAnnotation {
        
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let glTree: GeolocatedTree
    let title: String?
    let subtitle: String?
    let image: UIImage
    
    init(coordinates: CLLocationCoordinate2D, glTree: GeolocatedTree) {
        self.coordinate = coordinates
        self.glTree = glTree
        self.title = glTree.tree.name
        self.subtitle = glTree.tree.species?.localizedCapitalized
        self.image = UIImage(named: "Leaf")!
    }
}
