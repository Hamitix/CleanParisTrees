//
//  MapViewCoordinator.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 17/05/2022.
//

import Foundation
import MapKit


class MapViewCoordinator: NSObject, MKMapViewDelegate {
    
    var mapViewController: MapViewUIView
    
    init(_ parent: MapViewUIView) {
        self.mapViewController = parent
    }
    
    // when the annotation is selected
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        //Center the map on the annotation selected with the same zoom level
        let region = MKCoordinateRegion(center: view.annotation!.coordinate, span: mapView.region.span)
        
        mapView.setRegion(region, animated: true)
    }
    
}
