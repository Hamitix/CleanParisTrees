//
//  CoreDataController.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 05/05/2022.
//

import Foundation
import CoreData

import APILayer

public class CoreDataController: ObservableObject {
    
    static public let shared = CoreDataController()
    public let container: NSPersistentContainer
    
    let treeContainerName: String = "TreeCDModel"
    
    private init() {
                
        // Need to specify that the Core Data model is in another framework / project (In the DataLayer Bundle, in our case)
        lazy var managedObjectModel: NSManagedObjectModel = {
            let dataLayerBundle = Bundle(for: CoreDataController.self)
            
            let modelURL = dataLayerBundle.url(forResource: "TreeCDModel", withExtension: "momd")!
            return NSManagedObjectModel(contentsOf: modelURL)!
        }()
        
        container = NSPersistentContainer(name: treeContainerName, managedObjectModel: managedObjectModel)
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        }
    }
    
    public func saveGLTreesInContext(glTrees: [GeolocatedTree]) {
        let _ = glTrees.map { glTree in
            let CDTree = CDGeolocatedTree(context: self.container.viewContext)
            
            CDTree.cdTree = glTree.tree.ToTreeCoreData()
            CDTree.lat = glTree.lat
            CDTree.lng = glTree.lng
            CDTree.id = glTree.id
        }
        self.saveContext()
    }
    
    public func saveContext() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch (let error) {
                print("Error while saving new changes in context : \(error.localizedDescription)")
            }
        }
    }
    
    public func deleteAllTreesInContext() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CDGeolocatedTree.nameType)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try container.viewContext.execute(batchDeleteRequest)
        } catch (let error) {
            print("Error reseting db : \(error.localizedDescription)")
        }
    }
}

