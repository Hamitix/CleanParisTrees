//
//  CDGeolocatedTree+CoreDataProperties.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 05/05/2022.
//
//

import Foundation
import CoreData

import APILayer

extension CDGeolocatedTree: Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGeolocatedTree> {
        return NSFetchRequest<CDGeolocatedTree>(entityName: "CDGeolocatedTree")
    }
    
    @NSManaged public var id: Int
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var cdTree: CDTree
    
}

extension CDGeolocatedTree: CoreDataToGLTreeDomain {
    public func CDToGLTreeDomain()  -> GeolocatedTree {
        GeolocatedTree(tree: cdTree.CDToTreeDomain(), lng: lng, lat: lat)
    }
}

extension GeolocatedTree : DomainToGLTreeCoreData {
    func ToGLTreeCoreData() -> CDGeolocatedTree {
        
        let cdGlTree = CDGeolocatedTree(context: CoreDataController.shared.container.viewContext)
        
        cdGlTree.id = id
        cdGlTree.lat = lat
        cdGlTree.lng = lng
        cdGlTree.cdTree = tree.ToTreeCoreData()
        
        return cdGlTree
    }
}

extension CDGeolocatedTree {
    static let nameType = "CDGeolocatedTree"
}

