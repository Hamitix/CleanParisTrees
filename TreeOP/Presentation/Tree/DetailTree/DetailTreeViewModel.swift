//
//  DetailViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 12/04/2022.
//

import SwiftUI
import CoreLocation

class DetailTreeViewModel: ObservableObject {
    
    var favouriteTrees: FavouriteTrees?
    
    @Published var tree: GeolocatedTree?
    
    @Published var latitude: Double = 0
    @Published var longitude: Double = 0
    
    @Published var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D.init()
    @Published var annotationItems: [GeolocatedTree] = [GeolocatedTree]()
    
    func setup(_ favouriteTrees: FavouriteTrees) {
        self.favouriteTrees = favouriteTrees
    }
    
    func getStarIconName() -> String {
        //TODO: Resolve Bug : FavouriteTrees became nil when the star button is pressed & Map Marker disappear
        
        if let tree = tree, let favouriteTrees = favouriteTrees  {
            return favouriteTrees.isFavorite(tree: tree.tree) ? String(localized: "starFillIcon") : String(localized: "starIcon")
        }
        return String(localized: "errorIcon")
    }
    
    func displayTreeName() -> Text {
        if let tree = tree {
            return Text(LocalizedStringKey(tree.tree.name ?? "No Name"), comment: "treeNameComment")
        }
        return Text("No Name")
    }
    
    
    func getFullAddress(tree: Tree) -> String {
        if let address2 = tree.address2 {
            return address2.appending(" \(tree.address)")
        }
        return tree.address
    }
    
    func displayFullAddress() -> Text? {
        if let tree = tree {
            return Text("Address \(self.getFullAddress(tree: tree.tree).localizedCapitalized)", comment: "addressComment")
        }
        return nil
    }
    
    func toggleFavorite() {
        if let tree = tree, let favouriteTrees = favouriteTrees {
            favouriteTrees.toggleFavorite(treeID: tree.id)
        } else {
            //self.favouriteTrees = setup
        }
    }
    
    //MARK: Coordinates Methods
    func updateCoordinates() {
        if let tree = tree  {
            self.longitude = tree.lng
            self.latitude = tree.lat
            self.setCLLCoordinates()
            self.annotationItems = [tree]
        }
    }
    
    func setCLLCoordinates() {
        self.coordinates = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    func displayTrees () {
        if let favouriteTrees = self.favouriteTrees {
            print("favouriteTrees : \(favouriteTrees.treeIDs)")
        }
    }
}
