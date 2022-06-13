//
//  MapViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 16/05/2022.
//

import Foundation
import CoreLocation
import MapKit

import APILayer
import DomainLayer

import Resolver

protocol MapVMProtocol {
    func initLocation()
    func centerMapOnUser()
    func getTrees() async
    func handleSuccessTrees(_ trees: [GeolocatedTree])
    func getMapAnnotations()
    func resetAnnotations()
}

class MapViewModel: CLLocationManager, CLLocationManagerDelegate, ObservableObject, MapVMProtocol {
    
    @Injected var treeStore: TreeStore
    
    @Published var mapAnnotations: [TreeAnnotation] = []
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: K.Map.latParis, longitude: K.Map.longParis), span: MKCoordinateSpan(latitudeDelta: K.Map.latitudeDelta, longitudeDelta: K.Map.longitudeDelta))
    
    @Published var selectedTree: GeolocatedTree = GeolocatedTree.mock
    @Published var navigateToSelectedTreeDetailView: Bool = false
    
    private let locationManager: CLLocationManager = CLLocationManager()
    
    @Injected var networkMonitor: NetworkMonitor
    @Injected var getTreeListUseCase: GetTreeList
    
    
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
    
    func getTrees() async {
        let result = await getTreeListUseCase.fetch(startRow: 0, isLazy: false, fetchStrategy: .local)
        
        switch result {
        case .success(let trees):
            
            DispatchQueue.main.async {
                self.handleSuccessTrees(trees)
            }
            
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    internal func handleSuccessTrees(_ trees: [GeolocatedTree]) {
        getMapAnnotations()
    }
    
    func getMapAnnotations() {

        if treeStore.getNbOfTrees() < mapAnnotations.count {
            resetAnnotations()
        }
        
        let newAnnotations = treeStore.treeList.dropFirst(mapAnnotations.count).map {
            TreeAnnotation(coordinates: CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lng), glTree: $0) }
        
        mapAnnotations.append(contentsOf: newAnnotations)
    }
    
    internal func resetAnnotations() {
        self.mapAnnotations = []
    }
}
