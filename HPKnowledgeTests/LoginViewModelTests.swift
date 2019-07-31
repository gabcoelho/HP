//
//  LoginViewModelTests.swift
//  HPKnowledgeTests
//
//  Created by Gabriela Coelho on 25/02/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import XCTest

@testable import HPKnowledge

class LoginViewModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testInit() {
        // Given
        var sut: LoginViewModel
        // When
        sut = LoginViewModel()
        // Then
        XCTAssertNotNil(sut, "Invalid login view model instance")
    }
    
    func testValidatePasswordSuccess() {
        // Given
        var sut: LoginViewModel
        let password = "I solemnly swear that I am up to no good"
        let expectation = XCTestExpectation(description: "Testing password validation.")
        // When
        sut = LoginViewModel()
        // Then
        sut.validatePassword(password, completion: { (isValid) in
            XCTAssertTrue(isValid, "Password is valid.")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testValidatePasswordFailure() {
        // Given
        var sut: LoginViewModel
        let passwordGiven = "Blabla"
        let expectation = XCTestExpectation(description: "Testing password validation.")
        // When
        sut = LoginViewModel()
        // Then
        sut.validatePassword(passwordGiven, completion: { (isValid) in
            XCTAssertFalse(isValid, "Password is invalid.")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testValidateEmptyPassword() {
        // Given
        var sut: LoginViewModel
        let passwordGiven = ""
        let expectation = XCTestExpectation(description: "Testing password validation.")
        // When
        sut = LoginViewModel()
        // Then
        sut.validatePassword(passwordGiven, completion: { (isValid) in
            XCTAssertFalse(isValid, "Password is invalid.")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2.0)
    }
}
