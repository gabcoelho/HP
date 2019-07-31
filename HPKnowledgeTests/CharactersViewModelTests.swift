//
//  CharactersViewModelTests.swift
//  HPKnowledgeTests
//
//  Created by Gabriela Coelho on 26/02/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import XCTest
import RxSwift

@testable import HPKnowledge

class CharactersViewModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testInit() {
        // Given
        var sut: CharactersViewModel
        // When
        sut = CharactersViewModel()
        // Then
        XCTAssertNotNil(sut.charactersList.value, "Init succeeded.")
    }
    
    func testFetchCharacters() {
        // Given
        var sut: CharactersViewModel
        var list = [Characters]()
        let expectation = XCTestExpectation(description: "Expectation succeeded.")
        // When
        sut = CharactersViewModel()
        sut.fetchList { (characters) in
            list = characters
            expectation.fulfill()
        }
        // Then
        XCTAssertNotNil(list, "Fetch characters succeeded.")
    }
    
//    func testGetCharacter() {
//        // Given
//        var sut: CharactersViewModel
//        var character: Characters
//        let expectation = XCTestExpectation(description: "Expectation succeeded.")
//        // When
//        sut = CharactersViewModel()
//        sut.fetchList { (characters) in
//            expectation.fulfill()
//        }
//        // Then
//        wait(for: [expectation], timeout: 60.0)
//        character = sut.getCharacter(at: IndexPath(row: 0, section: 0))
//        XCTAssertNotNil(character, "Get character succeeded.")
//    }
    
    

}
