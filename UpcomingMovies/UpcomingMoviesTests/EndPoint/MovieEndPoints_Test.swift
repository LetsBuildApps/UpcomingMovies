//
//  EndPointTests.swift
//  UpcomingMoviesTests
//
//  Created by CHARNPREET SINGH on 4/8/21.
//

import XCTest
@testable import UpcomingMovies

class MovieEndPoints_Test: XCTestCase {

      var endPoint: EndPoint!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        endPoint = UpcomingMoviesEndPoints(path: .upcoming, section: .movies, apiKey: "0d9396afae9f4fe7bae0ce653bbee985")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        endPoint = nil
    }
    
    func test_can_Build_URL() {
        XCTAssertNotNil(endPoint.url)
    }
    func test_url_is_same_as_given_url() {
        let testURL : URL = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=0d9396afae9f4fe7bae0ce653bbee985&page=1")!
        
        XCTAssertEqual(endPoint.url, testURL)
    }
}

