//
//  HomeUITests.swift
//  HPKnowledgeUITests
//
//  Created by Gabriela Coelho on 26/02/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import XCTest

class HomeUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCollapseSideMenu() {
        // Given
        let app = XCUIApplication()
        let password = app.textFields["Password"]
        let loginButton = app.buttons["Enter"]
        waitForElementToAppear(element: password)
        password.tap()
        password.typeText("lol")
        loginButton.tap()
        // When
        let sideMenuButton = app.buttons["menu"]
        sideMenuButton.tap()
        let sideMenuTable = app.tables["SideMenuTable"]
        XCTAssert(sideMenuTable.cells.count == 2, "Cell count succeeded")
        // Then
        sideMenuButton.tap()
    }
}

