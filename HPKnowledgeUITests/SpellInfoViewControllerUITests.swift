//
//  SpellInfoViewControllerUITests.swift
//  HPKnowledgeUITests
//
//  Created by Gabriela Coelho on 27/02/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import XCTest

class SpellInfoViewControllerUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSpellsTable() {
        // Given
        let app = XCUIApplication()
        let password = app.textFields["Password"]
        let loginButton = app.buttons["Enter"]
        let sideMenuButton = app.buttons["menu"]
        let sideMenuTable = app.tables["SideMenuTable"]
        let charactersTable = app.tables["GenericTable"]
        let spellsCell = sideMenuTable.cells.element(boundBy: 1)
        let firstSpellCell = charactersTable.cells.element(boundBy: 0)
        let closeInfo = app.buttons["FecharSpellsInfo"]
        let backButton = app.buttons["Voltar"]
        // When
        waitForElementToAppear(element: password)
        password.tap()
        password.typeText("lol")
        loginButton.tap()
        sideMenuButton.tap()
        XCTAssert(sideMenuTable.cells.count == 2, "Cell count succeeded.")
        // Then
        spellsCell.tap()
        firstSpellCell.tap()
        closeInfo.tap()
        backButton.tap()
    }
}
