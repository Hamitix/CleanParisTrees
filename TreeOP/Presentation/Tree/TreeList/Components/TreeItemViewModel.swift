//
//  TreeItemViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 03/05/2022.
//

import Foundation
import Resolver


class TreeItemViewModel: ObservableObject {
    
    @LazyInjected private var bookmarkStore: BookmarkStore
    
    @Published var tree: GeolocatedTree
    @Published var isFavorite: Bool = false
    
    init(tree: GeolocatedTree) {
        self.tree = tree
        self.isFavorite = self.bookmarkStore.isFavorite(id: tree.id)
    }
    
    func toggleFavorite() {
        bookmarkStore.toggleFavorite(treeID: tree.id)
        isFavorite.toggle()
    }
    
    func getIsFavorite() {
        self.isFavorite = bookmarkStore.isFavorite(id: tree.id)
    }
}
