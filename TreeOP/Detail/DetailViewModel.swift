//
//  DetailViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 12/04/2022.
//

import SwiftUI
import CoreLocation

class DetailViewModel: ObservableObject {
    
    var favouriteTrees: FavouriteTrees?
    
    @Published var record: RecordsData?
    
    @Published var latitude: Double = 0
    @Published var longitude: Double = 0
    
    @Published var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D.init()
    @Published var annotationItems: [RecordsData] = [RecordsData]()
    
    func setup(_ favouriteTrees: FavouriteTrees) {
        self.favouriteTrees = favouriteTrees
    }
    
    func updateCoordinates() {
        if let record = record  {
            
            if record.geometry.coordinates.count >= 2 {
                self.longitude = record.geometry.coordinates[0]
                self.latitude = record.geometry.coordinates[1]
            }
            
            self.setCLLCoordinates()
            self.annotationItems = [record]
        }
    }
    
    func setCLLCoordinates() {
        self.coordinates = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    func getStarIconName() -> String {
        //TODO: Resolve Bug : FavouriteTrees became nil when the star button is pressed & Map Marker disappear
        
        if let record = record, let favouriteTrees = favouriteTrees {
            return favouriteTrees.isFavorite(tree: record.fields) ? "star.fill" : "star"
        } else {
            return "xmark.octagon"
        }
    }
    
    func displayTreeName() -> Text {
        if let record = record {
            return Text(LocalizedStringKey(record.fields.name ?? "No Name"), comment: "Indicate either the title or a default placeholder")
        }
        return Text("No Name")
    }
    
    func toggleFavorite() {
        if let record = record, let favouriteTrees = favouriteTrees {
            favouriteTrees.toggleFavorite(tree: record.fields)
        }
    }
}
