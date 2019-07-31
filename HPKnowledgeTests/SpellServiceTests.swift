//
//  SpellServiceTests.swift
//  HPKnowledgeTests
//
//  Created by Gabriela Coelho on 26/02/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import XCTest
import RxSwift

@testable import HPKnowledge

class SpellServiceTests: XCTestCase {
    
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()

    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testFetchSpells() {
        // Given
        var list = [Spell]()
        let expectation: XCTestExpectation
        // When
        expectation = XCTestExpectation(description: "Success")
        SpellService().getSpellsList().subscribe(onNext: { (spells) in
            guard let spells = spells else {
                XCTAssertFalse(false, "Spells not initiated.")
                return
            }
            list = spells
            expectation.fulfill()
        }).disposed(by: disposeBag)
        //Then
        wait(for: [expectation], timeout: 4.0)
        XCTAssertNotNil(list, "Fetching succeeded")
    }

}
