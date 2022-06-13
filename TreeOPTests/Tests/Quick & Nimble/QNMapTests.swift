//
//  QNMapsTests.swift
//  TreeOPTests
//
//  Created by Dylan HAMITI on 13/06/2022.
//

import XCTest
import CoreLocation
@testable import TreeOP

import DomainLayer

import Resolver
import Nimble
import Quick

class QNMapTests: XCTestCase {

    @LazyInjected var getTreeListUseCase: GetTreeList
    var mapAnnotations: [TreeAnnotation] = []
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mapAnnotations.removeAll()
        
        Resolver.registerMock()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testNumberOfAnnotationsAfterFetch() async {
        expect(self.mapAnnotations).toNot(beNil())
        expect(self.mapAnnotations).to(haveCount(0))
        
        let result = await getTreeListUseCase.fetch(startRow: 0, isLazy: true, fetchStrategy: .local)
        
        switch result {
        case .success(let trees):
            
            expect(result).to(beSuccess())
            
            let annotations = trees.dropFirst(mapAnnotations.count).map { TreeAnnotation(coordinates: CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lng), glTree: $0) }
            
            mapAnnotations = annotations
            
            
        case .failure:
            expect(result).to(beFailure())
            fail("The retrieving of the local data failed")
        }
                
        expect(self.mapAnnotations).to(haveCount(20))
    }
}
