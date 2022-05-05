//
//  DetailTreeViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 12/04/2022.
//

import SwiftUI
import CoreLocation
import Resolver

class DetailTreeViewModel: ObservableObject {
    
    @Injected private var bookmarkManager: BookmarkManager
    
    @Published var glTree: GeolocatedTree?
    
    @Published var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D.init()
    @Published var annotationItems: [GeolocatedTree] = [GeolocatedTree]()
    
    @Published var starIconName: String = String(localized: "starIcon")
    
    func setStarIconName() {
        if let glTree = glTree {
            starIconName =   String(localized: bookmarkManager.isFavorite(id: glTree.id) ? "starFillIcon" : "starIcon")
        }
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
    
    func toggleFavorite() {
        if let glTree = glTree {
            bookmarkManager.toggleFavorite(treeID: glTree.id)
            setStarIconName()
        }
    }
    
    //MARK: Coordinates Methods
    
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
    
}
