//
//  TreeOPTests.swift
//  TreeOPTests
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import XCTest
@testable import TreeOP

import DomainLayer
import APILayer

import Resolver

class TreeTests: XCTestCase {
        
    @LazyInjected var getTreeListUseCase: GetTreeList
    var geolocatedTrees: [GeolocatedTree] = []
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        geolocatedTrees.removeAll()
        
        Resolver.registerMock()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testNumberOfTreeOnLaunch() {
        XCTAssertNotNil(geolocatedTrees)
        XCTAssertEqual(geolocatedTrees.count, 0, "Number of items in the tree list is wrong")
    }
    
    func testNumberOfTreeAfterFirstFetch() async throws {
        XCTAssertNotNil(geolocatedTrees)
        XCTAssertEqual(geolocatedTrees.count, 0, "Number of items in the tree list is wrong")
        
        let result = await getTreeListUseCase.fetch(startRow: 0, isLazy: true, fetchStrategy: .local)
        
        switch result {
        case .success(let trees):
            geolocatedTrees.append(contentsOf: trees)
            
        case .failure:
            XCTFail("The retrieving of the local data failed")
        }
        
        XCTAssertEqual(geolocatedTrees.count, 20, "Number of items in the tree list is wrong")
    }
    
    
    func testNumberOfTreeAfterRandomFetch() async {
        
        XCTAssertNotNil(geolocatedTrees)
        XCTAssertEqual(geolocatedTrees.count, 0, "Number of items in the tree list is wrong")
        
        let randomFetch = Int.random(in: 1...10)
        for _ in 1...randomFetch {
        
            let result = await getTreeListUseCase.fetch(startRow: 0, isLazy: true, fetchStrategy: .local)
            
            switch result {
            case .success(let trees):
                geolocatedTrees.append(contentsOf: trees)
                
            case .failure:
                XCTFail("The retrieving of the local data failed")
                
            }
        }
        XCTAssertEqual(geolocatedTrees.count, 20 * randomFetch, "Number of items in the tree list is wrong")
    }
}
