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
    
    // When the annotation is selected
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        // Center the map on the annotation selected with the same zoom level
        let region = MKCoordinateRegion(center: view.annotation!.coordinate, span: mapView.region.span)
        
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = MKMapViewDefaultAnnotationViewReuseIdentifier

            if annotation is TreeAnnotation {
                if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                    annotationView.annotation = annotation
                    
                    annotationView.isEnabled = true
                    annotationView.canShowCallout = true
                                        
                    // Add a detail button in the right side of the callout
                    // to navigate and see the detail of the tree
                    annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                    
                    return annotationView
                    
                } else {
                    let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
                    return annotationView
                }
            }
            return nil
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        let treeAnnotation = view.annotation as! TreeAnnotation
        mapViewController.tappedOnCalloutInfoButton(glTree: treeAnnotation.glTree)
    }
}
