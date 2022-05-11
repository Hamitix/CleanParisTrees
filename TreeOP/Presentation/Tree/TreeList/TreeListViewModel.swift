//
//  TreeListViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import SwiftUI
import Resolver

class TreeListViewModel: ObservableObject {
    @Injected private var bookmarkManager: BookmarkManager
    
    private let networkMonitor = NetworkMonitor.shared
    private var treeList = [GeolocatedTree]()
    
    @Published var isLoadingRows: Bool = false
    private var currentRow: Int = 0
    
    @Published var filterButtonName: String = "Show Favourite Trees"
    @Published var isFilteringFavourites: Bool = false
    
    @Published var errorMessage: String = ""
    @Published var hasError: Bool = false
    
    var filteredTrees: [GeolocatedTree] {
        switch isFilteringFavourites {
        case false:
            return treeList
        case true:
            return treeList.filter { bookmarkManager.isFavorite(id: $0.id) }
        }
    }
    
    var getTreeListUseCase = GetTreeListUseCase()
    
    //MARK: Methods
    func getTreesData(startRow: Int = 0, forceRemote: Bool = false) async {
        
        errorMessage = ""
        let result = await getTreeListUseCase.fetch(startRow: startRow, forceRemote: forceRemote)
        
        switch result {
        case .success(let trees):
            DispatchQueue.main.async {
                self.treeList.append(contentsOf: trees)
                self.currentRow += K.OpenDataAPI.nbrRowPerRequest
                self.isLoadingRows = false
                if self.networkMonitor.isDeviceConnectedToInternet() { CoreDataController.shared.saveGLTreesInContext(glTrees: trees)
                }
            }
            
        case .failure(let error):
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.hasError = true
                self.isLoadingRows = false
            }
        }
    }
    
    //MARK: Refreshable Methods
    func refreshableAction() async -> Void {
        if networkMonitor.isDeviceConnectedToInternet() {
            resetTreeList()
            await getTreesData()
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
        
        
        //Need to change this condition
        if treeList.last?.id == item.id {
            await self.loadMoreContent()
        }
    }
    
    private func loadMoreContent() async {
        guard !isLoadingRows && networkMonitor.isDeviceConnectedToInternet() else {
            return
        }
        
        isLoadingRows = true
        await getTreesData(startRow: currentRow + 1)
    }
    
    
    //MARK: Favourites Methods
    func toggleFilterFavourites() {
        isFilteringFavourites.toggle()
        filterButtonName = isFilteringFavourites ? "Show All Trees" : "Show Favourite Trees"
    }
    
    func toggleFavorite(tree: Tree) {
        bookmarkManager.toggleFavorite(treeID: tree.id)
    }
}
