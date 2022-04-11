//
//  MainViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import Foundation


class MainViewModel: ObservableObject {
    
    @Published var records = [RecordsData]()
    
    let dataService: DataService
    
    init(dataService: DataService = ParisOpenDataAPI()) {
        self.dataService = dataService
    }
    
    func getTreesData() {
        dataService.apiGetDataTrees {[weak self] recordsData in
            DispatchQueue.main.async {
                self?.records = recordsData
            } 
        }
    }
}
