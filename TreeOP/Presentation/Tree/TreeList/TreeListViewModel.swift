//
//  TreeListViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import SwiftUI
import Resolver

import APILayer
import DomainLayer
import DataLayer

protocol TreeListVMProtocol {
    func getTreesData(startRow: Int) async
    func handleSuccessTrees(trees: [GeolocatedTree], startRow: Int)
    func refreshableAction() async
    func resetTreeList()
    func loadMoreRowsIfNeeded(currentItem item : GeolocatedTree?) async
    func loadMoreContent() async
    func toggleFilterFavourites()
    func toggleFavorite(tree: Tree)
}

class TreeListViewModel: ObservableObject, TreeListVMProtocol {
    
    //MARK: Properties
    @Injected private var bookmarkStore: BookmarkStore
    @Injected var treeStore: TreeStore
    @Injected var networkMonitor: NetworkMonitor
    

    @Published var isLoadingRows: Bool = true
    private var currentRow: Int = 0
    
    @Published var filterButtonName: String = "Show Favourite Trees"
    @Published var isFilteringFavourites: Bool = false
    
    var filteredTrees: [GeolocatedTree] {
        switch isFilteringFavourites {
        case false:
            return treeStore.treeList
        case true:
            return treeStore.treeList.filter { bookmarkStore.isFavorite(id: $0.id) }
        }
    }
    
    @Injected var getTreeListUseCase: GetTreeList
    
    //MARK: Methods
    func getTreesData(startRow: Int = 0) async {
        
        let result = await getTreeListUseCase.fetch(startRow: startRow, isLazy: true, fetchStrategy: networkMonitor.fetchStrategy)
        
        switch result {
            
        case .success(let trees):
            DispatchQueue.main.async {
                self.handleSuccessTrees(trees: trees, startRow: startRow)
            }
            
        case .failure:
                DispatchQueue.main.async {
                self.isLoadingRows = false
            }
        }
    }
    
    internal func handleSuccessTrees(trees: [GeolocatedTree], startRow: Int) {
        
        treeStore.appendTreesInList(treesToInsert: trees)
        currentRow = treeStore.getNbOfTrees()
        isLoadingRows = false
        
        if networkMonitor.isDeviceConnectedToInternet() {
            if startRow == 0 {
                CoreDataController.shared.deleteAllTreesInContext()
            }
            CoreDataController.shared.saveGLTreesInContext(glTrees: trees)
        }
    }
    
    //MARK: Refreshable Methods
    func refreshableAction() async -> Void {
        if networkMonitor.isDeviceConnectedToInternet() {
            resetTreeList()
            await getTreesData()
        }
    }
    
    internal func resetTreeList() {
        DispatchQueue.main.async {
            self.treeStore.resetList()
        }
    }
    
    
    //MARK: List Lazy Loading Methods
    func loadMoreRowsIfNeeded(currentItem item : GeolocatedTree?) async {
        guard let item = item else {
            await self.loadMoreContent()
            return
        }
        
        let thresholdIndex = treeStore.treeList.index(treeStore.treeList.endIndex, offsetBy: -4)
        if treeStore.treeList.firstIndex(where: {$0.id == item.id}) == thresholdIndex {
            await loadMoreContent()
        }
    }
    
    internal func loadMoreContent() async {
        guard !isLoadingRows else {
            return
        }
        
        isLoadingRows = true
        await getTreesData(startRow: currentRow + 1)
    }
    
    
    
    //MARK: Bookmark Methods
    func toggleFilterFavourites() {
        isFilteringFavourites.toggle()
        filterButtonName = isFilteringFavourites ? "Show All Trees" : "Show Favourite Trees"
    }
    
    func toggleFavorite(tree: Tree) {
        bookmarkStore.toggleFavorite(treeID: tree.id)
    }
}
