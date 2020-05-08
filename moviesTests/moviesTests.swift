//
//  moviesTests.swift
//  moviesTests
//
//  Created by Joyce Rosario Batista on 06/05/2020.
//  Copyright © 2020 Joyce Rosario Batista. All rights reserved.
//

import XCTest
@testable import Movies

class moviesTests: XCTestCase {
    
    override class func setUp() {
        super.setUp()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    func testGetPopularMovies() {
        let requestExpectation = expectation(description: "Get Popular Movies")
        
//        MockURLProtocol.requestHandler = { request in
//            let data = MockedData.populaMoviesJSON.data
//            let response = HTTPURLResponse.init(url: request.url!, statusCode: ResponseCode.success.intValue(), httpVersion: "2.0", headerFields: nil)!
//            return (response, data)
//        }
        
        NetworkClient().getPopularMovies { (popularMovies) in
            print(popularMovies)
            XCTAssertNotNil(popularMovies)
            requestExpectation.fulfill()
        }
        
        wait(for: [requestExpectation], timeout: 10.0)
    }
    
}
