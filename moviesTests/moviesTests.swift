//
//  moviesTests.swift
//  moviesTests
//
//  Created by Joyce Rosario Batista on 06/05/2020.
//  Copyright © 2020 Joyce Rosario Batista. All rights reserved.
//

import XCTest
import SwiftyJSON
import Alamofire
@testable import Movies

class moviesTests: XCTestCase {
    
    let mockSession: Session = {
        let configuration: URLSessionConfiguration = {
            let configuration = URLSessionConfiguration.default
            configuration.protocolClasses = [MockURLProtocol.self]
            return configuration
        }()
        
        return Session(configuration: configuration)
    }()
    
    override class func setUp() {
        super.setUp()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    func testGetPopularMovies() {
        let requestExpectation = expectation(description: "Get Popular Movies")
        
        MockURLProtocol.requestHandler = { request in
            let data = MockedData.populaMoviesJSON.data
            let response = HTTPURLResponse.init(url: request.url!, statusCode: ResponseCode.success.intValue(), httpVersion: "2.0", headerFields: nil)!
            return (response, data)
        }
        
        Movies.NetworkClient(withSession: mockSession).getPopularMovies { (popularMovies) in
            XCTAssertNotNil(popularMovies)
            XCTAssertEqual(popularMovies!["JoyceTest"].stringValue, "Joyce")
            XCTAssertNotNil(popularMovies!["results"].array)
            let popularMoviesArray = popularMovies!["results"].array
            XCTAssertTrue(popularMoviesArray![0]["video"].boolValue)
            requestExpectation.fulfill()
        }        
        wait(for: [requestExpectation], timeout: 10.0)
    }
    
    func testGetPopularMoviesFail() {
        let requestExpectation = expectation(description: "Get Popular Movies Fail")
        
        MockURLProtocol.requestHandler = { request in
            let data = MockedData.noData.data
            let response = HTTPURLResponse.init(url: request.url!, statusCode: ResponseCode.notFound.intValue(), httpVersion: "2.0", headerFields: nil)!
            return (response, data)
        }
        
        Movies.NetworkClient(withSession: mockSession).getPopularMovies { (popularMovies) in
           print(popularMovies)
            requestExpectation.fulfill()
        }
        wait(for: [requestExpectation], timeout: 10.0)
    }
    
    func testGetMovieDetails() {
        let requestExpectation = expectation(description: "Get Movie Details")
        
        MockURLProtocol.requestHandler = { request in
            let data = MockedData.movieDetailsJSON.data
            let response = HTTPURLResponse.init(url: request.url!, statusCode: ResponseCode.success.intValue(), httpVersion: "2.0", headerFields: nil)!
            return (response, data)
        }
        
        Movies.NetworkClient(withSession: mockSession).getMovieDetails(1234, { (movie) in
            print(movie)
            requestExpectation.fulfill()
        })
        
        wait(for: [requestExpectation], timeout: 10.0)
    }
    
    func testDummy() {
        XCTAssertTrue(true)
    }
    
}
