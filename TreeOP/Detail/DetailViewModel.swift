//
//  DetailViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 12/04/2022.
//

import Foundation

class DetailViewModel: ObservableObject {
    
    @Published var record: RecordsData?
    
    @Published var annotationItems: [RecordsData] = [RecordsData]()
    @Published var latitude: Double = 0
    @Published var longitude: Double = 0
    
    init(record: RecordsData?) {
        self.record = record
    }
    
    func updateCoordinates() {
        if let safeRecord = record  {
            
            if(safeRecord.geometry.coordinates.count >= 2) {
                self.longitude = safeRecord.geometry.coordinates[0]
                self.latitude = safeRecord.geometry.coordinates[1]
            }
            
            self.annotationItems = [safeRecord]
        }
    }
}
