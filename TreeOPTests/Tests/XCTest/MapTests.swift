//
//  MapTests.swift
//  TreeOPTests
//
//  Created by Dylan HAMITI on 10/06/2022.
//

import XCTest
import CoreLocation
@testable import TreeOP

import DomainLayer

import Resolver


class MapTests: XCTestCase {
    
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
        XCTAssertNotNil(mapAnnotations)
        XCTAssertEqual(mapAnnotations.count, 0)
        
        let result = await getTreeListUseCase.fetch(startRow: 0, isLazy: true, fetchStrategy: .local)
        
        switch result {
        case .success(let trees):
            
            let annotations = trees.dropFirst(mapAnnotations.count).map { TreeAnnotation(coordinates: CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lng), glTree: $0) }
            
            mapAnnotations = annotations
            
            
        case .failure:
            XCTFail("The retrieving of the local data failed")
        }
        
        XCTAssertEqual(mapAnnotations.count, 20)
    }
}
