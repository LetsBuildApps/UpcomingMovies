//
//  Poster.swift
//  UpcomingMoviesTests
//
//  Created by CHARNPREET SINGH on 9/8/21.
//

import XCTest
@testable import UpcomingMovies
class Poster_Tests: XCTestCase {

    var endPoint: EndPoint!
    override func setUp() {
        endPoint = PostersEndpoint(path: Poster.path.rawValue, host: Poster.host.rawValue, posterSize: .original, filePath: "1234566")
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        endPoint = nil
    }
    
    func test_can_Build_URL() {
        XCTAssertNotNil(endPoint.url, "URL is not nil")
    }
    func test_url_is_same_as_given_url() {
        let expectedURL : URL = URL(string: "https://image.tmdb.org/t/p/original/1234566")!
        XCTAssertEqual(endPoint.url, expectedURL)
    }
}
