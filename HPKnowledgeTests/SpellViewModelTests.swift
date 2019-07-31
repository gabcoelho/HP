//
//  SpellViewModelTests.swift
//  HPKnowledgeTests
//
//  Created by Gabriela Coelho on 26/02/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import XCTest
import RxSwift

@testable import HPKnowledge

class SpellViewModelTests: XCTestCase {

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
        var sut: SpellsViewModel
        // When
        sut = SpellsViewModel()
        //Then
        XCTAssertNotNil(sut.spellsList.value, "Fetch Spells succeeded.")
    }
    
    func testFetchSpells() {
        // Given
        var sut: SpellsViewModel
        var list = [Spell]()
        let expectation = XCTestExpectation(description: "Expectation spells succeeded.")
        // When
        sut = SpellsViewModel()
        sut.fetchSpells { (spells) in
            guard let spells = spells else {
                return
            }
            list = spells
            expectation.fulfill()
        }
        //Then
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(list, "Fetch Spells succeeded.")
    }
    
    func testListOfSpells() {
        // Given
        var sut: SpellsViewModel
        var spells: [Spell]
        // When
        sut = SpellsViewModel()
        spells = sut.listOfSpells()
        //Then
        XCTAssertNotNil(spells, "Get list succeeded.")
    }
    
//    func testGetSpell() {
//        // Given
//        var sut: SpellsViewModel
//        var spell: Spell
//        let expectation = XCTestExpectation(description: "Expectation spells succeeded.")
//        // When
//        sut = SpellsViewModel()
//        sut.fetchSpells { (spells) in
//            expectation.fulfill()
//        }
//        //Then
//        wait(for: [expectation], timeout: 10.0)
//        spell = sut.getSpell(at: IndexPath(row: 0, section: 0))
//        XCTAssertNotNil(spell, "Get spell succeeded.")
//    }
}
