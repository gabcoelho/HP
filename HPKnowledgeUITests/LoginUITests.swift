//
//  LoginUITests.swift
//  HPKnowledgeUITests
//
//  Created by Gabriela Coelho on 26/02/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import XCTest

class LoginUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLoginViewController() {
        // Given
        let app = XCUIApplication()
        let password = app.textFields["Password"]
        let loginButton = app.buttons["Enter"]
        // When
        waitForElementToAppear(element: password)
        password.tap()
        password.typeText("lol")
        // Then
        loginButton.tap()
    }
    
    func testWrongPasswordLogin() {
        // Given
        let app = XCUIApplication()
        let password = app.textFields["Password"]
        let loginButton = app.buttons["Enter"]
        // When
        waitForElementToAppear(element: password)
        password.tap()
        password.typeText("bla")
        // Then
        loginButton.tap()

    }

}
