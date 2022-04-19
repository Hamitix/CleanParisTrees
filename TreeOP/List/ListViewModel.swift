//
//  MainViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var records = [RecordsData]()
    @Published var isLoadingRows: Bool = false
    private var currentRow: Int = 0
    private var canLoadMoreRows: Bool = true
        
    let dataService: TreeDataService
    
    init(dataService: TreeDataService = ParisOpenDataAPI()) {
        self.dataService = dataService
        loadMoreContent()
    }
    
    func getTreesData(startRow: Int = 0) {
        dataService.apiGetDataTrees(startRow: startRow) {[weak self] recordsData in
            DispatchQueue.main.async {
                self?.records.append(contentsOf: recordsData)
                self?.currentRow += K.OpenDataAPI.nbrRowPerRequest
                self?.isLoadingRows = false
            }
        }
    }
    
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
}
