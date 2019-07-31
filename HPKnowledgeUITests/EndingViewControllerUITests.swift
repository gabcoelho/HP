//
//  EndingViewControllerUITests.swift
//  HPKnowledgeUITests
//
//  Created by Gabriela Coelho on 27/02/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import XCTest

class EndingViewControllerUITests: XCTestCase {
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
        waitForElementToAppear(element: password)
        password.tap()
        password.typeText("lol")
        loginButton.tap()
        // When
        let quizCollectionView = app.collectionViews["QuizCollection"]
        let firstCell = quizCollectionView.cells.element(boundBy: 0)
        let nextButton = app.buttons["NextButton"]
        let resultsButton = app.buttons["ResultsButton"]
        let optionAButton = firstCell.buttons["OptionAButton"]
        let playAgainButton = app.buttons["PlayAgainButton"]
        // Then
        optionAButton.tap()
        nextButton.tap()
        for _ in 1...16 {
            nextButton.tap()
        }
        resultsButton.tap()
        playAgainButton.tap()
    }
}
