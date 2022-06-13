//
//  BookmarkStore.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 27/04/2022.
//

import Foundation

class BookmarkStore: ObservableObject {
    
    @Published var treeIDs: Set<Int> = []
    
    init() {
        let savedValues = UserDefaults.standard.array(forKey: K.UserDefaults.keyFavTrees) as? [Int] ?? []
        self.treeIDs = Set(savedValues)
    }
    
    func isFavorite(id treeID: Int) -> Bool {
         self.treeIDs.contains(treeID)
    }
    
    private func saveInUserDefaults() {
        UserDefaults.standard.set(Array(treeIDs), forKey: K.UserDefaults.keyFavTrees)
    }
    
    func toggleFavorite(treeID: Int) {
        if self.isFavorite(id: treeID) {
            self.treeIDs.remove(treeID)
        } else {
            self.treeIDs.insert(treeID)
        }
        self.saveInUserDefaults()
    }
    
    func reset(){
        treeIDs.removeAll()
        UserDefaults.standard.set([]  as [Int], forKey: K.UserDefaults.keyFavTrees)
    }
}
