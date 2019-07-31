//
//  NestworkDispatcherTests.swift
//  HPKnowledgeTests
//
//  Created by Gabriela Coelho on 31/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import XCTest
import RxSwift

@testable import HPKnowledge

class NestworkDispatcherTests: XCTestCase {

    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        super.tearDown()
    }

    
    func testCreateHttpRequest() {
        // Given
        let characters = URLConstants.characters
        let charactersUrl: URL
        let request: URLRequest
        let data = Data()
        let dispatcher: NetworkDispatcher
        // When
        dispatcher = NetworkDispatcher()
        charactersUrl = URL(string: characters)!
        request = dispatcher.createHTTPRequest(httpMethod: .get, url: charactersUrl, parameters: data)
        // Then
        XCTAssertNotNil(data, "Succeed in getting data.")
        XCTAssertNotNil(request, "Request creation succeeded.")
        
    }
    
    func testDispatchSuccess() {
        // Given
        let sut: NetworkDispatcher
        let data = Data()
        let urlRequest: URLRequest
        let expectation = XCTestExpectation(description: "Data was downloaded")
        // When
        sut = NetworkDispatcher()
        urlRequest = sut.createHTTPRequest(httpMethod: .get, url: URL(string: URLConstants.characters)!, parameters: data)
        sut.dispatch(urlRequest) { (data, response) in
            XCTAssertNotNil(data, "No data was downloaded.")
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testDispatchFailue() {
        // Given
        let sut: NetworkDispatcher
        let data = Data()
        let urlRequest: URLRequest
        let expectation = XCTestExpectation(description: "Data was downloaded")
        // When
        sut = NetworkDispatcher()
        urlRequest = sut.createHTTPRequest(httpMethod: .get, url: URL(string: URLConstants.apiHost)!, parameters: data)
        sut.dispatch(urlRequest) { (data, response) in
            XCTAssertNil(data, "No data was downloaded.")
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testResponseArray() {
        // Given
        let sut: NetworkDispatcher
        let data = Data()
        let urlRequest: URLRequest
        // When
        sut = NetworkDispatcher()
        urlRequest = sut.createHTTPRequest(httpMethod: .get, url: URL(string: URLConstants.apiHost)!, parameters: data)
        let response: Observable<[Characters]?> = sut.responseArray(urlRequest)
        // Then
        
    }
}


private final class MockNetworkDispatcher: NetworkDispatcher {

}
