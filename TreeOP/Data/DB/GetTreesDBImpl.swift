//
//  GetTreesDBImpl.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 10/05/2022.
//

import Foundation
import CoreData

struct GetTreesDBImpl : LocalTreeDataSource {
    
    func getTreeListLocal(offset: Int, isLazy: Bool) throws -> [GeolocatedTree] {
        
        let fetchRequest: NSFetchRequest<CDGeolocatedTree>
        
        fetchRequest = CDGeolocatedTree.fetchRequest()
        fetchRequest.fetchOffset = offset
        if isLazy {
            fetchRequest.fetchLimit = K.OpenDataAPI.nbrRowPerRequest
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
