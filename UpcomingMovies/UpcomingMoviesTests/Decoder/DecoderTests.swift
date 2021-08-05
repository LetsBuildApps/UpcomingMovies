//
//  DecoderTests.swift
//  UpcomingMoviesTests
//
//  Created by CHARNPREET SINGH on 3/8/21.
//

import XCTest
@testable import UpcomingMovies

class DecoderTests: XCTestCase {

    var decoder: DataDecoder!
    var data: Data!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        decoder = JsonDecoder()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        decoder = nil
        data = nil
    }
    
    func test_throwsEmptyData_Error() {
       data =  """
            """.data(using: .utf8)!
        runTest(with: data, and: DecodingErrors.dataSetEmpty)
    }
    func test_throws_KeyNotFound() {
        data =  """
            {
            "nam": "charnpreet"
            }
            """.data(using: .utf8)!
        runTest(with: data, and: DecodingErrors.keyIsMissing)
    }
    
    func test_throws_DataTypeMismatched() {
        data =  """
            {
            "name": 123
            }
            """.data(using: .utf8)!
        runTest(with: data, and: DecodingErrors.typeMisMatch)
    }
    
    func test_Throws_ValueNotFound() {
        data =  """
            {
            "name": null
            }
            """.data(using: .utf8)!
        
        runTest(with: data, and: .valueNotFound)
    }
    
    func test_Throws_DataIsCrupted() {
        data =  """
            {
            "name": &*&#&#&&#&##
            }
            """.data(using: .utf8)!
        
        runTest(with: data, and: .invalidData)
    }
    
    private func runTest(with data: Data, and expectedError: DecodingErrors){
        do {
          let _: MockUser = try mockDeocer().decode(dataToBeDecoed: data)
        } catch let error {
            XCTAssertEqual(error as? DecodingErrors, expectedError)
        }
    }
}



struct mockDeocer: DataDecoder {
    /**
            * data shouldn't be empty
            * shouldn't be invalid
            *  should decode
     */
    func decode<T: Decodable>(dataToBeDecoed data: Data) throws -> T {
        if data.isEmpty {
            throw DecodingErrors.dataSetEmpty
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        }catch DecodingError.keyNotFound(_, _) {
            throw DecodingErrors.keyIsMissing
        } catch  DecodingError.typeMismatch(_, _) {
            throw DecodingErrors.typeMisMatch
        }catch DecodingError.valueNotFound(_, _) {
            throw DecodingErrors.valueNotFound
        } catch DecodingError.dataCorrupted(_) {
            throw DecodingErrors.invalidData
        }
    }

}


struct MockUser: Decodable {
    var name: String
}
