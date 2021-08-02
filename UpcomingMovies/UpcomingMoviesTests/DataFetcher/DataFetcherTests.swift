//
//  DataFetcherTests.swift
//  UpcomingMoviesTests
//
//  Created by CHARNPREET SINGH on 2/8/21.
//

import XCTest
@testable import UpcomingMovies

class DataFetcherTests: XCTestCase {

    var fetcher: FetcherAPI!
    override func setUp() {
        fetcher = RemoteDataFetcher()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here.
        fetcher = nil
    }
    
    func test_RemoteReturnsData() {
        fetcher.load(from: URL(string: "https://www.google.com.au/")!, resultHandler: { data, error in
            XCTAssertNotNil(data, "failed to load data")
        })
    }

    func test_Remote_throws_error() {
        fetcher.load(from: URL(string: "https://www.google.com.au/")!, resultHandler: {_, error in
            XCTAssertNotNil(error, "error is not thrown")
        })
    }

}

protocol FetcherAPI {
    func load(from url: URL, resultHandler: @escaping(Data?, Error?)-> ())
}

class RemoteDataFetcher: FetcherAPI {
    enum networkError: Error {
        case notNetwork
        case invalidURL
        case NoAPIKey
        case faildToConnectToServer
    }
    
    func load(from url: URL, resultHandler: @escaping (Data?, Error?) -> ()) {
        let data =  """
            {
            "name": "charnpreet"
            }
            """.data(using: .utf8)!
        
        resultHandler(nil, networkError.notNetwork)
    }
    
    
}
