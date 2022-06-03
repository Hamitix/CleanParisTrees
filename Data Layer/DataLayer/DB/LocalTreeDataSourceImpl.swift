//
//  LocalTreeDataSourceImpl.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 10/05/2022.
//

import Foundation
import CoreData

import APILayer

public struct LocalTreeDataSourceImpl : LocalTreeDataSource {
    
    public init() { }
    
    public func getTreeListLocal(startRow: Int, isLazy: Bool) throws -> [GeolocatedTree] {
        
        let nbRowToRetrieveInLazy: Int = 20
                
        let fetchRequest: NSFetchRequest<CDGeolocatedTree>
        
        fetchRequest = CDGeolocatedTree.fetchRequest()
        fetchRequest.fetchOffset = startRow
        if isLazy {
            fetchRequest.fetchLimit = nbRowToRetrieveInLazy
        }
        
        let context = CoreDataController.shared.container.viewContext
        
        do {
            let CDGlTrees = try context.fetch(fetchRequest)
            
            if CDGlTrees.isEmpty {
                throw DBError.alreadyRetrievedAll
            }
            
            return CDGlTrees.map { cdGLTree in
                cdGLTree.CDToGLTreeDomain()
            }
        } catch {
            throw DBError.fetchingInContext
        }
    }
}
