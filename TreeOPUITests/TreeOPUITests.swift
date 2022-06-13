//
//  TreeOPUITests.swift
//  TreeOPUITests
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import XCTest

import Quick
import Nimble

class TreeOPUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["testing"]
        app.launch()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNavigationTitleOnLaunch() {
        // XCTAssertTrue(self.app.navigationBars["Liste des Arbres"].exists)
        expect(self.app.navigationBars["Liste des Arbres"].exists).to(beTrue())
    }
    
    func testGoToDetailPageOfFirstTreeOfTheList() {

        let cellCounts = app.tables["treeList"].cells.count
        
        // XCTAssertTrue(cellCounts > 0)
        // XCTAssertTrue(cellCounts == 20)
        expect(cellCounts).to(beGreaterThan(0))
        expect(cellCounts).to(equal(20))
        
        let firstTree = app.tables["treeList"].cells.element(boundBy: 0)
                
        // XCTAssertTrue(firstTree.exists)
        expect(firstTree.exists).to(beTrue())
        firstTree.tap()
    }
    
    func testGoToWeatherViewAndReloadData() {
                
        // XCTAssertTrue(self.app.buttons["Météo"].exists)
        expect(self.app.buttons["Météo"].exists).to(beTrue())
        let weatherButton = self.app.buttons["Météo"]
        weatherButton.tap()
    
        // XCTAssertTrue(self.app.buttons["Actualiser"].exists)
        expect(self.app.buttons["Actualiser"].exists).to(beTrue())
        let reloadDataButton = self.app.buttons["Actualiser"]
        reloadDataButton.tap()
    
        // The data was reload without failure
        // XCTAssertFalse(self.app.staticTexts["Impossible de traiter les données"].exists)
        expect(self.app.staticTexts["Impossible de traiter les données"].exists).to(beFalse())
    }
}
