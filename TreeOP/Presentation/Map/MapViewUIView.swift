//
//  MapViewUIView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 16/05/2022.
//


import SwiftUI
import MapKit

struct MapViewUIView: UIViewRepresentable {
    
    @StateObject  var mapViewModel: MapViewModel
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
        
        // Compass addition
        addCompassToMap(to: mapView)
        
        // Scale addition
        addScaleToMap(to: mapView)
        
        
        mapView.addAnnotations(mapViewModel.mapAnnotations)
        
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
        scale.scaleVisibility = .visible // always visible
        mapView.addSubview(scale)
        
        scale.translatesAutoresizingMaskIntoConstraints = false
        scale.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 12).isActive = true
        scale.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -40).isActive = true
        
    }
    
    private func addAnnotationIfAvailable(in mapView: MKMapView) {
        
        if mapView.annotations.count < mapViewModel.mapAnnotations.count && !mapViewModel.mapAnnotations.isEmpty {
            
            mapView.addAnnotations(mapViewModel.mapAnnotations)
        }
    }
}
