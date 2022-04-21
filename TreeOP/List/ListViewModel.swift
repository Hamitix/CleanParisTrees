//
//  MainViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import SwiftUI

class ListViewModel: ObservableObject {
    
    private var favouriteTrees: FavouriteTrees?
    private var records = [RecordsData]()
    
    @Published var isLoadingRows: Bool = false
    private var currentRow: Int = 0
    private var canLoadMoreRows: Bool = true
    
    @Published var filterButtonName: String = "Show Favourite Trees"
    @Published var isFilteringFavourites: Bool = false
    
    var filteredRecords : [RecordsData] {
        switch self.isFilteringFavourites {
        case false:
            return self.records
        case true:
            if let favouriteTrees = favouriteTrees {
                return self.records.filter { favouriteTrees.isFavorite(tree: $0.fields) }
            } else {
                return self.records
            }
        }
    }
    
    let dataService: TreeDataService
    
    init(dataService: TreeDataService = ParisOpenDataAPI()) {
        self.dataService = dataService
        loadMoreContent()
    }
    
    func setup(favTrees favouriteTrees: FavouriteTrees) {
        self.favouriteTrees = favouriteTrees
    }
    
    func getTreesData(startRow: Int = 0) {
        dataService.apiGetDataTrees(startRow: startRow, nbrRows: 20) { (response: Result<[RecordsData],ErrorAPI> ) in
            
            switch response {
                
            case .success(let records):
                DispatchQueue.main.async {
                    self.records.append(contentsOf: records)
                    self.currentRow += K.OpenDataAPI.nbrRowPerRequest
                    self.isLoadingRows = false
                }
                
            case .failure(let error):
                Network.printErrorAPI(error: error)
                DispatchQueue.main.async {
                    self.isLoadingRows = false
                }
            }
        }
    }
    
    //MARK: List Lazy Loading Methods
    
    func loadMoreRowsIfNeeded(currentRow row: RecordsData?) {
        guard let row = row else {
            loadMoreContent()
            return
        }
        
        let thresholdIndex = records.index(records.endIndex, offsetBy: -5)
        if records.firstIndex(where: {$0.id == row.id}) == thresholdIndex {
            loadMoreContent()
        }
    }
    
    private func loadMoreContent() {
        guard !isLoadingRows && canLoadMoreRows else {
            return
        }
        
        isLoadingRows = true
        getTreesData(startRow: currentRow == 0 ? 0 : currentRow + 1)
    }
    
    //MARK: Favourites Methods
    
    func toggleFilterFavourites() {
        self.isFilteringFavourites.toggle()
        self.filterButtonName = self.isFilteringFavourites ? "Show All Trees" : "Show Favourite Trees"
    }
    
    func toggleFavorite(record: RecordsData) {
        if let favouriteTrees = favouriteTrees {
            favouriteTrees.toggleFavorite(tree: record.fields)
        }
    }
}
