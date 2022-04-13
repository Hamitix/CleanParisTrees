//
//  DetailViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 12/04/2022.
//

import Foundation
import MapKit

class DetailViewModel: ObservableObject {
    
    var record: RecordsData
    
    @Published var mapRegion = MKCoordinateRegion.init()
    
    init(record: RecordsData) {
        self.record = record
    }
    
    func getMapCoordinates() {
        self.mapRegion = MKCoordinateRegion(center: self.record.geometry.coordinateCL, span: MKCoordinateSpan(latitudeDelta: K.Map.latitudeDelta, longitudeDelta: K.Map.longitudeDelta))
    }
}
