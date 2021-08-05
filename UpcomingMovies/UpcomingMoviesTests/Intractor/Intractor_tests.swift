//
//  Intractor_tests.swift
//  UpcomingMoviesTests
//
//  Created by CHARNPREET SINGH on 5/8/21.
//

import XCTest

class Intractor_tests: XCTestCase {

    var intractor: Intractable!
    override func setUp() {
        intractor = Intractor()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        intractor = nil
    }
    
    func test_load_returns_viewModel() {
       intractor.loadData(using: URL(string: "www.abc.com.au")!, callback: {reuslt in
            XCTAssertEqual(reuslt?.name, "charnpreet")
        })
    
    }
}


struct  ViewModel {
    var name: String
}
protocol Intractable {
    func loadData(using url: URL, callback: @escaping (ViewModel?)->())
}

class Intractor: Intractable{
    func loadData(using url: URL, callback: @escaping (ViewModel?) -> ()) {
        loadDataFromAPI(from: url, callback: {viewModel in
            callback(viewModel)
        })
    }
    

    var decoder: mockDeocer = mockDeocer()
    var fetcher: RemoteDataFetcher = RemoteDataFetcher()
    
    func loadDataFromAPI(from url: URL,  callback: @escaping (ViewModel?) -> ()) {
        fetcher.load(from: url, resultHandler: { data, error in
            guard let data = data else {return}
            let result =  self.loadDataFromDecoder(dataToBeDecoder: data)
            callback(result)
        })
    }
    func loadDataFromDecoder(dataToBeDecoder data: Data) -> ViewModel? {
        do {
            let v: MockUser = try decoder.decode(dataToBeDecoed: data)
            return ViewModel(name: v.name)
        } catch let error {
            print(error)
        }
        return nil
    }
}
