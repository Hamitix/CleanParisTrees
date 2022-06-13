//
//  BookmarkTest.swift
//  TreeOPTests
//
//  Created by Dylan HAMITI on 10/06/2022.
//

import XCTest
@testable import TreeOP

import APILayer

class BookmarkTests: XCTestCase {
    
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
        XCTAssertNotNil(sut?.bookmarkStore.treeIDs)
        
        sut?.toggleFavorite(tree: mockTree)
        XCTAssertEqual(sut?.bookmarkStore.treeIDs.count, 1)
    }
    
    func testAddThenRemoveATreeInFavourite() {
        testAddATreeInFavourite()
        
        sut?.toggleFavorite(tree: mockTree)
        XCTAssertEqual(sut?.bookmarkStore.treeIDs.count, 0)
    }
}
