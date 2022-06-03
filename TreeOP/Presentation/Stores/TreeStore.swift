//
//  TreeStore.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 27/05/2022.
//

import Foundation

import APILayer

class TreeStore: ObservableObject {
    
    @Published var treeList: [GeolocatedTree] = []
    
    func setTreeList(newTrees: [GeolocatedTree]) {
        self.treeList = newTrees
    }
    
    
    func appendTreesInList(treesToInsert: [GeolocatedTree]) {
        self.treeList.append(contentsOf: treesToInsert)
    }
    
    
    func resetList() {
        treeList = []
    }
    
    func isListEmpty() -> Bool {
        treeList.isEmpty
    }
    
    func getNbOfTrees() -> Int {
        treeList.count
    }
 
}
