//
//  FavouritesTrees.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 15/04/2022.
//

import Foundation

class FavouriteTrees: ObservableObject {
    
    @Published var treeIDs: Set<Int>
    
    init() {
        let savedValues = UserDefaults.standard.array(forKey: K.UserDefaults.keyFavTrees) as? [Int] ?? []
        treeIDs = Set(savedValues)
    }
    
    func isFavorite(tree: Tree) -> Bool {
        treeIDs.contains(tree.id)
    }
    
    func toggleFavorite(treeID: Int) {
        if treeIDs.contains(treeID) {
            treeIDs.remove(treeID)
        } else {
            treeIDs.insert(treeID)
        }
        UserDefaults.standard.set(Array(treeIDs), forKey: K.UserDefaults.keyFavTrees)
    }
    
    func reset(){
        UserDefaults.standard.set([] as [Int], forKey: K.UserDefaults.keyFavTrees)
    }
}
