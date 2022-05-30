//
//  MapViewUIView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 16/05/2022.
//


import SwiftUI
import MapKit
import Resolver

struct MapViewUIView: UIViewRepresentable {
    
    @InjectedObject private var mapViewModel: MapViewModel
    @State private var tracking: MapUserTrackingMode = .follow
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        
        // registration of the classic annotation view
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        // registration of the annotation view when in cluster
        mapView.register(ClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier )
        
        
        mapView.setRegion(mapViewModel.mapRegion, animated: true)
        mapView.contentMode = .center
        mapView.showsUserLocation = true
        
        addCompassToMap(to: mapView)
        addScaleToMap(to: mapView)
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context){
        addAnnotationIfAvailable(in: mapView)
    }
    
    
    private func addCompassToMap(to mapView: MKMapView) {
        mapView.showsCompass = false
        mapView.userTrackingMode = .followWithHeading
        
        let compassButton = MKCompassButton(mapView: mapView)
        compassButton.compassVisibility = .visible
        mapView.addSubview(compassButton)
        
        compassButton.translatesAutoresizingMaskIntoConstraints = false
        compassButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -12).isActive = true
        compassButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 12).isActive = true
    }
    
    private func addScaleToMap(to mapView: MKMapView) {
        
        let scale = MKScaleView(mapView: mapView)
        scale.scaleVisibility = .visible
        mapView.addSubview(scale)
        
        scale.translatesAutoresizingMaskIntoConstraints = false
        scale.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 12).isActive = true
        scale.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -40).isActive = true
        
    }
    
    private func addAnnotationIfAvailable(in mapView: MKMapView) {
        
        if mapView.annotations.count > mapViewModel.treeStore.getNbOfTrees() {
            deleteAllAnnotations(in: mapView)
        }
        mapView.addAnnotations(mapViewModel.mapAnnotations)
    }
    
    private func deleteAllAnnotations(in mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
    }
}
