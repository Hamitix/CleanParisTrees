//
//  TreeItemViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 03/05/2022.
//

import Foundation
import Resolver

import APILayer

protocol TreeItemVMProtocol {
    func toggleFavorite()
    func getIsFavorite()
}

class TreeItemViewModel: ObservableObject {
    
    @LazyInjected private var bookmarkStore: BookmarkStore
    
    @Published var glTree: GeolocatedTree
    @Published var isFavorite: Bool = false
    
    init(tree: GeolocatedTree) {
        self.glTree = tree
        self.isFavorite = self.bookmarkStore.isFavorite(id: tree.id)
    }
    
    func toggleFavorite() {
        bookmarkStore.toggleFavorite(treeID: glTree.id)
        isFavorite.toggle()
    }
    
    func getIsFavorite() {
        self.isFavorite = bookmarkStore.isFavorite(id: glTree.id)
    }
    
    func getAccessibilityLabel() -> String.LocalizationValue {
        if let treeName = glTree.tree.name {
            return isFavorite ? "labelGoToDetailTreeFav \(treeName)" : "labelGoToDetailTree \(treeName)"
        } else {
            return "No Name"
        }
    }
}
