//
//  MainViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var records = [RecordsData]()
        
    let dataService: TreeDataService
    
    init(dataService: TreeDataService = ParisOpenDataAPI()) {
        self.dataService = dataService
    }
    
    func getTreesData() {
        dataService.apiGetDataTrees(startRow: 0) {[weak self] recordsData in
            DispatchQueue.main.async {
                self?.records = recordsData
            }
        }
    }
}
