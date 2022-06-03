//
//  DetailTreeViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 12/04/2022.
//

import SwiftUI
import CoreLocation

import Resolver

import APILayer

protocol DetailTreeVMProtocol {
    func setStarIconName()
    func displayTreeName() -> Text
    func getFullAddress(tree: Tree) -> String
    func displayFullAddress() -> Text?
    func toggleFavorite()
    func isTreeInFavourites() -> Bool
    func updateCoordinates(completion: @escaping (_ coordinates: CLLocationCoordinate2D) -> Void)
    func getTreeCoordinates() -> CLLocationCoordinate2D
}

class DetailTreeViewModel: ObservableObject {
    
    @Injected private var bookmarkStore: BookmarkStore
    
    @Published var glTree: GeolocatedTree?
    
    @Published var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D.init()
    
    @Published var annotationItems: [GeolocatedTree] = [GeolocatedTree]()
    
    @Published var starIconName: String = String(localized: "starIcon")
    
    init(glTree: GeolocatedTree?) {
        self.glTree = glTree
    }
    
    func setStarIconName() {
        starIconName = String(localized: isTreeInFavourites() ? "starFillIcon" : "starIcon")
    }
    
    
    func displayTreeName() -> Text {
        if let glTree = glTree {
            return Text(LocalizedStringKey(glTree.tree.name ?? "No Name"), comment: "treeNameComment")
        }
        return Text("No Name")
    }
    
    
    private func getFullAddress(tree: Tree) -> String {
        if let address2 = tree.address2 {
            return address2.appending(" \(tree.address)")
        }
        return tree.address
    }
    
    func displayFullAddress() -> Text? {
        if let glTree = glTree {
            return Text("Address \(self.getFullAddress(tree: glTree.tree).localizedCapitalized)", comment: "addressComment")
        }
        return nil
    }
    
    
    //MARK: Bookmark & Favourites Methods 
    func toggleFavorite() {
        if let glTree = glTree {
            bookmarkStore.toggleFavorite(treeID: glTree.id)
            setStarIconName()
        }
    }
    
    func isTreeInFavourites() -> Bool {
        guard let glTree = glTree else {
            return false
        }
        return bookmarkStore.isFavorite(id: glTree.id)
    }
    
    
    //MARK: Coordinates & Map Methods
    private func setCLLCoordinates(newLat: Double, newLng: Double) -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: newLat, longitude: newLng)
    }
    
    func updateCoordinates(completion: @escaping (_ coordinates: CLLocationCoordinate2D) -> Void) {
        if let glTree = glTree  {
            self.coordinates = setCLLCoordinates(newLat: glTree.lat, newLng: glTree.lng)
            self.annotationItems = [glTree]
            
            DispatchQueue.main.async {
                completion(self.coordinates)
            }
        }
    }
        
    func getTreeCoordinates() -> CLLocationCoordinate2D {
        coordinates
    }
}
