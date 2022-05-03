//
//  MainViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import SwiftUI
import Resolver

class TreeListViewModel: ObservableObject {

    @Injected private var bookmarkManager: BookmarkManager
    
    private var treeList = [GeolocatedTree]()
    
    @Published var isLoadingRows: Bool = false
    private var currentRow: Int = 0
    
    @Published var filterButtonName: String = "Show Favourite Trees"
    @Published var isFilteringFavourites: Bool = false
    
    @Published var errorMessage: String = ""
    @Published var hasError: Bool = false
    
    var filteredTrees: [GeolocatedTree] {
        switch self.isFilteringFavourites {
        case false:
            return self.treeList
        case true:
            return self.treeList.filter { bookmarkManager.isFavorite(id: $0.id) }
        }
    }
    var getTreeListUseCase = GetTreeListUseCase(treeRepository: TreeRepositoryImpl(dataSource: TreeAPIImpl()))
    
    func getTreesData(startRow: Int = 0) async {
        
        errorMessage = ""
        let result = await getTreeListUseCase.execute(startRow: startRow)
        
        switch result {
        case .success(let trees):
            DispatchQueue.main.async {
                self.treeList.append(contentsOf: trees)
                self.currentRow += K.OpenDataAPI.nbrRowPerRequest
                self.isLoadingRows = false
            }
            
        case .failure(let error):
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.hasError = true
                self.isLoadingRows = false
            }
        }
    }
    
    //MARK: List Lazy Loading Methods
    
    func loadMoreRowsIfNeeded(currentItem item : GeolocatedTree?) async {
        guard let item = item else {
            await self.loadMoreContent()
            return
        }
        
        if self.treeList[treeList.count - 3] == item {
            await self.loadMoreContent()
        }
    }
    
    private func loadMoreContent() async {
        guard !isLoadingRows else {
            return
        }
        
        isLoadingRows = true
        await self.getTreesData(startRow: self.currentRow + 1)
    }
    
    //MARK: Favourites Methods
    
    func toggleFilterFavourites() {
        self.isFilteringFavourites.toggle()
        self.filterButtonName = self.isFilteringFavourites ? "Show All Trees" : "Show Favourite Trees"
    }
    
    func toggleFavorite(tree: Tree) {
        bookmarkManager.toggleFavorite(treeID: tree.id)
    }
}
