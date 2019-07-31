//
//  SideMenuViewModelTests.swift
//  HPKnowledgeTests
//
//  Created by Gabriela Coelho on 26/02/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import XCTest
import RxSwift

@testable import HPKnowledge

class SideMenuViewModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    
    func testGetMenuItems() {
        // Given
        var sut: SideMenuViewModel
        var sideMenu: [SideMenu]
        // When
        sut = SideMenuViewModel()
        sideMenu = sut.getMenuItens()
        // Then
        XCTAssertNotNil(sideMenu, "Get side menu items succeeded.")
    }
    
    func testGetSideMenuItemAtIndex() {
        // Given
        var sut: SideMenuViewModel
        var sideMenu: SideMenu
        // When
        sut = SideMenuViewModel()
        sideMenu = sut.menuItem(at: IndexPath(row: 1, section: 0))
        // Then
        XCTAssertNotNil(sideMenu, "Get side menu items succeeded.")
    }
}
