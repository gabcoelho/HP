//
//  QuizCollectionViewUITests.swift
//  HPKnowledgeUITests
//
//  Created by Gabriela Coelho on 27/02/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import XCTest

class QuizCollectionViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testQuizCollectionView() {
        // Given
        let app = XCUIApplication()
        let password = app.textFields["Password"]
        let loginButton = app.buttons["Enter"]
        let quizCollectionView = app.collectionViews["QuizCollection"]
        let firstCell = quizCollectionView.cells.element(boundBy: 0)
        waitForElementToAppear(element: password)
        password.tap()
        password.typeText("lol")
        loginButton.tap()
        // When
        let nextButton = app.buttons["NextButton"]
        let optionAButton = firstCell.buttons["OptionAButton"]
        let optionBButton = firstCell.buttons["OptionBButton"]
        let optionCButton = firstCell.buttons["OptionCButton"]
        let optionDButton = firstCell.buttons["OptionDButton"]
        // Then
        optionAButton.tap()
        nextButton.tap()
        optionCButton.tap()
        nextButton.tap()
        optionBButton.tap()
        nextButton.tap()
        optionDButton.tap()
    }
    
    func testQuizShakeView() {
        // Given
        let app = XCUIApplication()
        let password = app.textFields["Password"]
        let loginButton = app.buttons["Enter"]
        let quizCollectionView = app.collectionViews["QuizCollection"]
        let firstCell = quizCollectionView.cells.element(boundBy: 0)
        waitForElementToAppear(element: password)
        password.tap()
        password.typeText("lol")
        loginButton.tap()
        // When
        let nextButton = app.buttons["NextButton"]
        let optionBButton = firstCell.buttons["OptionBButton"]
        // Then
        optionBButton.tap()
        nextButton.tap()
    }
}
