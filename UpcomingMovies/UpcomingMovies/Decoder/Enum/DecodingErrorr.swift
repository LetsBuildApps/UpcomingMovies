//
//  DecodingErrorr.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 3/8/21.
//

import Foundation


enum DecodingErrors: Error, Equatable {
    case invalidData
    case faildToDecode
    case keyIsMissing(key: String)
    case typeMisMatch
    case valueNotFound
    case dataSetEmpty
}

extension DecodingErrors: LocalizedError {
    var dis: String? {
        switch self {
        case .invalidData:
            return "Data is crupted"
        case .faildToDecode:
            return "Unable to Decode Data"
        case .typeMisMatch:
            return "type did not match"
        case .valueNotFound:
            return "expected value is null"
        case .dataSetEmpty:
            return "passed in data set is empty"
        case .keyIsMissing(key: let key):
            return "key is missing :- \(key)"
        }
    }
}


    
