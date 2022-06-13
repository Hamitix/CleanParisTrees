//
//  QNBookmarkTests.swift
//  TreeOPTests
//
//  Created by Dylan HAMITI on 13/06/2022.
//

import XCTest
@testable import TreeOP

import APILayer

import Quick
import Nimble

class QNBookmarkTests: XCTestCase {

    var sut: TreeListViewModel?
    let mockTree: Tree = Tree.mock
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = TreeListViewModel()
        sut?.bookmarkStore.reset()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testAddATreeInFavourite() {
        
        expect(self.sut?.bookmarkStore.treeIDs).toNot(beNil())
        sut?.toggleFavorite(tree: mockTree)
        expect(self.sut?.bookmarkStore.treeIDs).to(haveCount(1))
    }
    
    func testAddThenRemoveATreeInFavourite() {
        testAddATreeInFavourite()
        
        sut?.toggleFavorite(tree: mockTree)
        expect(self.sut?.bookmarkStore.treeIDs).to(haveCount(0))
    }
}
