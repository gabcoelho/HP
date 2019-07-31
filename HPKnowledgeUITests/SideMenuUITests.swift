//
//  SideMenuUITests.swift
//  HPKnowledgeUITests
//
//  Created by Gabriela Coelho on 27/02/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import XCTest

class SideMenuUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSelectionSideMenu() {
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
        let firstCell = sideMenuTable.cells.element(boundBy: 0)
        let secondCell = sideMenuTable.cells.element(boundBy: 1)
        let backButton = app.buttons["Voltar"]
        firstCell.tap()
        backButton.tap()
        secondCell.tap()
        backButton.tap()
        sideMenuButton.tap()
    }
    
    
}

extension XCTestCase {
    func waitForElementToAppear(element: XCUIElement, timeout: TimeInterval = 10,  file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")
        
        expectation(for: existsPredicate,
                    evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: timeout) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after \(timeout) seconds."
                self.recordFailure(withDescription: message, inFile: file, atLine: Int(line), expected: true)
            }
        }
    }

}
