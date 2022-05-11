//
//  TreeDBImpl.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 10/05/2022.
//

import Foundation
import CoreData

struct TreeDBImpl : LocalTreeDataSource {
    
    func getTreeListLocal() throws -> [GeolocatedTree] {
        
        let fetchRequest: NSFetchRequest<CDGeolocatedTree>
        fetchRequest = CDGeolocatedTree.fetchRequest()
        
        let context = CoreDataController.shared.container.viewContext
        
        do {
            let CDGlTrees = try context.fetch(fetchRequest)
            
            return CDGlTrees.map { cdGLTree in
                cdGLTree.CDToGLTreeDomain()
            }
        } catch {
            throw DBError.fetchingInContext
        }
    }
}
