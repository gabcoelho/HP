//
//  QuizCollectionViewCellViewModelTests.swift
//  HPKnowledgeTests
//
//  Created by Gabriela Coelho on 26/02/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import XCTest
import RxSwift

@testable import HPKnowledge

class QuizCollectionViewCellViewModelTests: XCTestCase {
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testVerifyAnswerWrong() {
        // Given
        let answer = "One"
        let rightAnswer = "Two"
        var correction: Bool = true
        var sut: QuizCollectionViewCellViewModel
        let expectation = XCTestExpectation(description: "Verify answer expectations succeeded.")
        // When
        sut = QuizCollectionViewCellViewModel()
        sut.verifyAnswer(with: answer, rightAnswer: rightAnswer) { (isCorrect) in
            correction = isCorrect
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertFalse(correction, "Wrong answer verification succeeded.")
    }

    func testVerifyAnswerRight() {
        // Given
        let answer = "One"
        let rightAnswer = "One"
        var correction: Bool = true
        var sut: QuizCollectionViewCellViewModel
        let expectation = XCTestExpectation(description: "Verify answer expectations succeeded.")
        // When
        sut = QuizCollectionViewCellViewModel()
        sut.verifyAnswer(with: answer, rightAnswer: rightAnswer) { (isCorrect) in
            correction = isCorrect
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(correction, "Wrong answer verification succeeded.")
    }
    
    func testVerifyAnswerNil() {
        // Given
        let answer: String? = nil
        let rightAnswer = "One"
        var correction: Bool = true
        var sut: QuizCollectionViewCellViewModel
        let expectation = XCTestExpectation(description: "Verify answer expectations succeeded.")
        // When
        sut = QuizCollectionViewCellViewModel()
        sut.verifyAnswer(with: answer, rightAnswer: rightAnswer) { (isCorrect) in
            correction = isCorrect
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertFalse(correction, "Wrong answer verification succeeded.")
    }
}
