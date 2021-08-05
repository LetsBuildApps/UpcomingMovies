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
    case keyIsMissing
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
        case .keyIsMissing:
            return "key is missing"
        case .typeMisMatch:
            return "type did not match"
        case .valueNotFound:
            return "expected value is null"
        case .dataSetEmpty:
            return "passed in data set is empty"
        }
    }
}


