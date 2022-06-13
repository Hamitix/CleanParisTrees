//
//  TreeTests.swift
//  TreeOPTests
//
//  Created by Dylan HAMITI on 13/06/2022.
//

import XCTest
@testable import TreeOP

import DomainLayer
import APILayer

import Resolver
import Quick
import Nimble


class QuickNimbleTreeTests: XCTestCase {
        
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
        
        expect(self.geolocatedTrees).toNot(beNil())
        expect(self.geolocatedTrees).to(haveCount(0))
    }
    
    func testNumberOfTreeAfterFirstFetch() async throws {
        
        expect(self.geolocatedTrees).toNot(beNil())
        expect(self.geolocatedTrees).to(haveCount(0))
        
        let result = await getTreeListUseCase.fetch(startRow: 0, isLazy: true, fetchStrategy: .local)
        
        switch result {
        case .success(let trees):
            expect(result).to(beSuccess())
            geolocatedTrees.append(contentsOf: trees)
            
        case .failure:
            expect(result).to(beFailure())
            fail("The retrieving of the local data failed")
        }
                        
        expect(self.geolocatedTrees).to(haveCount(20))
    }
    
    
    func testNumberOfTreeAfterRandomFetch() async {
        
        expect(self.geolocatedTrees).toNot(beNil())
        expect(self.geolocatedTrees).to(haveCount(0))
                
        let randomFetch = Int.random(in: 1...10)
        for _ in 1...randomFetch {
        
            let result = await getTreeListUseCase.fetch(startRow: 0, isLazy: true, fetchStrategy: .local)
            
            switch result {
            case .success(let trees):
                expect(result).to(beSuccess())
                geolocatedTrees.append(contentsOf: trees)
                
            case .failure:
                expect(result).to(beFailure())
                fail("The retrieving of the local data failed")
            }
        }

        expect(self.geolocatedTrees).to(haveCount(20 * randomFetch))
    }
}

