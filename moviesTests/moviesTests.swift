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
    
    // MARK: Network Tests:
    
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
            let popularMoviesArray = popularMovies!["results"].array
            XCTAssertNotNil(popularMoviesArray)
            XCTAssertTrue(popularMoviesArray![0]["video"].boolValue)
            requestExpectation.fulfill()
        }        
        wait(for: [requestExpectation], timeout: 10.0)
    }
    
    func testGetMovieDetails() {
        let requestExpectation = expectation(description: "Get Movie Details")
        
       MockURLProtocol.requestHandler = { request in
            let data = MockedData.movieDetailsJSON.data
            let response = HTTPURLResponse.init(url: request.url!, statusCode: ResponseCode.notFound.intValue(), httpVersion: "2.0", headerFields: nil)!
            return (response, data)
        }
        
        Movies.NetworkClient(withSession: mockSession).getMovieDetails(1234, { (movieDetails) in
            XCTAssertNotNil(movieDetails)
            XCTAssertEqual(movieDetails!["JoyceTest"].stringValue, "Joyce")
            XCTAssertEqual(movieDetails!["original_title"].stringValue, "Ad Astra")
            XCTAssertFalse(movieDetails!["adult"].boolValue)
            let crew = movieDetails!["credits"]["crew"].array
            XCTAssertNotNil(crew)
            XCTAssertEqual(crew![0]["name"].stringValue, "Brad Pitt")
            requestExpectation.fulfill()
        })
        
        wait(for: [requestExpectation], timeout: 10.0)
    }
    
    // MARK: Global functions tests:
    
    func testGetStringFromDate() {
        XCTAssertNotNil(getStringFromDate(date: Date(), withFormat: "dd/MM/aaaa"))
    }
    
}
