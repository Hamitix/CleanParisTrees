//
//  MapViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 16/05/2022.
//

import Foundation
import CoreLocation
import MapKit

class MapViewModel: CLLocationManager, CLLocationManagerDelegate, ObservableObject {
    
    @Published var treeList = [GeolocatedTree]()
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: K.Map.latParis, longitude: K.Map.longParis), span: MKCoordinateSpan(latitudeDelta: K.Map.latitudeDelta, longitudeDelta: K.Map.longitudeDelta))
    
    @Published var backgroundColorName: String = NetworkMonitor.shared.isDeviceConnectedToInternet() ? "background" : "redError"
    
    private let locationManager: CLLocationManager = CLLocationManager()
    private var getTreeListLocalUseCase = GetTreeListLocal()
    
    let networkMonitor = NetworkMonitor.shared
    
    func initLocation() {
        if locationManager.authorizationStatus == .notDetermined {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        centerMapOnUser()
    }
    
    func centerMapOnUser() {
        mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? K.Map.latParis, longitude: location?.coordinate.longitude ?? K.Map.longParis), span: MKCoordinateSpan(latitudeDelta: K.Map.latitudeDelta, longitudeDelta: K.Map.longitudeDelta))
    }
    
    func getTrees() {
        let result = getTreeListLocalUseCase.fetch(startRow: 0, isLazy: false)
        
        switch result {
        case .success(let trees):
            treeList = trees
            
        case .failure(let error):
            print("error : \(error)")
        }
    }
}
