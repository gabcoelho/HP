//
//  HomeViewModelTests.swift
//  HPKnowledgeTests
//
//  Created by Gabriela Coelho on 25/02/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import XCTest
import RxSwift

@testable import HPKnowledge

class HomeViewModelTests: XCTestCase {

    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testInit() {
        // Given
        var sut: HomeViewModel
        // When
        sut = HomeViewModel()
        // Then
        XCTAssertNotNil(sut, "Home view model instance succeeded.")
    }

    func testUpdateFunctions() {
        // Given
        var sut: HomeViewModel
        // When
        sut = HomeViewModel()
        sut.updateQuestion()
        sut.updateProgressSlider()
        sut.updateCurrentQuestionIndex(with: 2)
        // Then
        XCTAssertEqual(sut.nextQuestion, 1, "UpdateQuestion test succeeded.")
        XCTAssertEqual(sut.successRate.value, Float(1), "UpdateProgressSlider succeeded.")
        XCTAssertEqual(sut.currentQuestion.value, 2, "UpdateCurrentQuestion succeeded.")
    }
    
    func testResetData() {
        // Given
        var sut: HomeViewModel
        // When
        sut = HomeViewModel()
        sut.resetData()
        // Then
        XCTAssertEqual(sut.nextQuestion, 0, "Next question reset succeeded.")
        XCTAssertEqual(sut.currentQuestion.value, sut.nextQuestion, "Current question reset succeeded.")
        XCTAssertEqual(sut.successRate.value, Float(0), "Success rate resset succeeded.")
    }
    
    func testNextButtonQuestionNotHiddenObservable() {
        // Given
        var sut: HomeViewModel
        // When
        sut = HomeViewModel()
        sut.updateCurrentQuestionIndex(with: 10)
        sut.nextButtonQuestion()
        // Then
        XCTAssertEqual(sut.nextQuestionButtonIsHidden.value, false, "Next button is not hidden succeeded.")
        XCTAssertEqual(sut.resultsButtonIsHidden.value, true, "Result button is hidden succeeded.")
    }

    func testNextButtonQuestionHiddenObservable() {
        // Given
        var sut: HomeViewModel
        // When
        sut = HomeViewModel()
        sut.updateCurrentQuestionIndex(with: 17)
        sut.nextButtonQuestion()
        // Then
        XCTAssertEqual(sut.nextQuestionButtonIsHidden.value, true, "Next button is not hidden succeeded.")
        XCTAssertEqual(sut.resultsButtonIsHidden.value, false, "Result button is hidden succeeded.")
    }
    
    func testDataForEndingDisappointedViewController() {
        // Given
        var sut: HomeViewModel
        // When
        sut = HomeViewModel()
        for _ in 0...2 {
            sut.updateProgressSlider()
        }
        let result = sut.dataForEndingViewController()
        // Then
        XCTAssertEqual(result, "Wow, an T for you, because you sucked. Moony is disappointed.", "TestEnding succeeded.")
    }
    
    func testDataForEndingMehViewController() {
        // Given
        var sut: HomeViewModel
        // When
        sut = HomeViewModel()
        for _ in 0...5 {
            sut.updateProgressSlider()
        }
        let result = sut.dataForEndingViewController()
        // Then
        XCTAssertEqual(result, "Meh, you get an A for that", "TestEnding meh succeeded.")
    }
    
    func testDataForEndingExceededViewController() {
        // Given
        var sut: HomeViewModel
        // When
        sut = HomeViewModel()
        for _ in 0...10 {
            sut.updateProgressSlider()
        }
        let result = sut.dataForEndingViewController()
        // Then
        XCTAssertEqual(result, "Ok, you exceed our expectations. Prongs, lets give an E to the kid.", "TestEnding exceeded succeeded.")
    }
    
    func testDataForEndingOwnViewController() {
        // Given
        var sut: HomeViewModel
        // When
        sut = HomeViewModel()
        for _ in 0...14 {
            sut.updateProgressSlider()
        }
        let result = sut.dataForEndingViewController()
        // Then
        XCTAssertEqual(result, "FINALLY! An O! Not exactly newt level but congrats!", "TestEnding exceeded succeeded.")
    }
}
