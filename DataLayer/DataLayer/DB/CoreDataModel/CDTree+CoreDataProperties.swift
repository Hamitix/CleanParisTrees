//
//  CDTree+CoreDataProperties.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 05/05/2022.
//
//

import Foundation
import CoreData

import APILayer

extension CDTree: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTree> {
        return NSFetchRequest<CDTree>(entityName: "CDTree")
    }

    @NSManaged public var name: String?
    @NSManaged public var species: String?
    @NSManaged public var address: String?
    @NSManaged public var address2: String?
    @NSManaged public var circumference: Int
    @NSManaged public var height: Int
    @NSManaged public var id: Int
    @NSManaged public var parentGlTree: CDGeolocatedTree

}

extension CDTree: CoreDataToTreeDomain {
    public func CDToTreeDomain() -> Tree {
        Tree(id: id, name: name, species: species, address: address ?? String(localized: "No Address"), address2: address2, height: height, circumference: circumference)
    }
}

extension Tree : DomainToTreeCoreData {
    func ToTreeCoreData() -> CDTree {
        
        let  cdTree = CDTree(context: CoreDataController.shared.container.viewContext)
        
        cdTree.id = id
        cdTree.name = name
        cdTree.species = species
        cdTree.address = address
        cdTree.address2 = address2
        cdTree.height = height
        cdTree.circumference = circumference
        
        return cdTree
    }
}

