//
//  DetailViewModel.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 12/04/2022.
//

import Foundation
import CoreLocation

class DetailViewModel: ObservableObject {
    
    @Published var record: RecordsData?
    
    @Published var latitude: Double = 0
    @Published var longitude: Double = 0
    
    @Published var cllCoordinates: CLLocationCoordinate2D = CLLocationCoordinate2D.init()
    @Published var annotationItems: [RecordsData] = [RecordsData]()
    
    func updateCoordinates() {
        if let record = record  {
            
            if(record.geometry.coordinates.count >= 2) {
                self.longitude = record.geometry.coordinates[0]
                self.latitude = record.geometry.coordinates[1]
            }
            
            self.setCLLCoordinates()
            self.annotationItems = [record]
        }
    }
    
    func setCLLCoordinates() {
        self.cllCoordinates = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
