//
//  CoreDataController.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 05/05/2022.
//

import Foundation
import CoreData


class CoreDataController: ObservableObject {
    
    static let shared = CoreDataController()
    let container: NSPersistentContainer
    
    private init() {
        
        container = NSPersistentContainer(name: K.CoreData.treeContainerName)
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        }
    }
    
    func saveGLTreesInContext(glTrees: [GeolocatedTree]) {
        let _ = glTrees.map { glTree in
            let CDTree = CDGeolocatedTree(context: self.container.viewContext)
            
            CDTree.cdTree = glTree.tree.ToTreeCoreData()
            CDTree.lat = glTree.lat
            CDTree.lng = glTree.lng
            CDTree.id = glTree.id
        }
        self.saveContext()
    }
    
    func saveContext() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch (let error) {
                print("Error while saving new changes in context : \(error.localizedDescription)")
            }
        }
    }
    
    func deleteAllTreesInContext() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CDGeolocatedTree.nameType)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try container.viewContext.execute(batchDeleteRequest)
        } catch (let error) {
            print("Error reseting db : \(error.localizedDescription)")
        }
    }
}

