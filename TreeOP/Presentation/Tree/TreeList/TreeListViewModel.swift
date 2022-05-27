//
//  TreeListViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import SwiftUI
import Resolver

class TreeListViewModel: ObservableObject {
    
    //MARK: Properties
    @Injected private var bookmarkStore: BookmarkStore
    
    @Injected var networkMonitor: NetworkMonitor
    
    private var treeList = [GeolocatedTree]()
    
    @Published var isLoadingRows: Bool = true
    private var currentRow: Int = 0
    
    @Published var filterButtonName: String = "Show Favourite Trees"
    @Published var isFilteringFavourites: Bool = false
    
    var filteredTrees: [GeolocatedTree] {
        switch isFilteringFavourites {
        case false:
            return treeList
        case true:
            return treeList.filter { bookmarkStore.isFavorite(id: $0.id) }
        }
    }
    
    @Injected var getTreeListUseCase: GetTreeList
    
    //MARK: Methods
    func getTreesData(startRow: Int = 0) async {
        
        let result = await getTreeListUseCase.fetch(startRow: startRow, isLazy: true, fetchStrategy: networkMonitor.fetchStrategy)
        
        switch result {
            
        case .success(let trees):
            DispatchQueue.main.async {
                self.handleSuccessTrees(trees)
            }
            
        case .failure:
            DispatchQueue.main.async {
                self.isLoadingRows = false
            }
        }
    }
    
    private func handleSuccessTrees(_ trees: [GeolocatedTree]) {
        treeList.append(contentsOf: trees)
        currentRow = treeList.count
        isLoadingRows = false
        if networkMonitor.isDeviceConnectedToInternet() {
            CoreDataController.shared.saveGLTreesInContext(glTrees: trees)
        }
    }
    
    func isListEmpty() -> Bool {
        self.treeList.isEmpty
    }
    
    
    //MARK: Refreshable Methods
    func refreshableAction() async -> Void {
        if networkMonitor.isDeviceConnectedToInternet() {
            resetTreeList()
            await getTreesData(startRow: 0)
        }
    }
    
    private func resetTreeList() {
        DispatchQueue.main.async {
            self.treeList = []
        }
    }
    
    
    //MARK: List Lazy Loading Methods
    func loadMoreRowsIfNeeded(currentItem item : GeolocatedTree?) async {
        guard let item = item else {
            await self.loadMoreContent()
            return
        }
        
        let thresholdIndex = treeList.index(treeList.endIndex, offsetBy: -4)
        if treeList.firstIndex(where: {$0.id == item.id}) == thresholdIndex {
            await loadMoreContent()
        }
    }
    
    private func loadMoreContent() async {
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
