//
//  RemoeteErrors.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 3/8/21.
//

import Foundation


enum RemoeteErrors: Error {
    case notAuthenticated
    case notFound
    case networkProblem
    case badRequest
    case requestFailed
    case invalidData
    
    init(httpResponse: HTTPURLResponse) {
        switch httpResponse.statusCode {
        case 400:
            self = RemoeteErrors.badRequest
        case 401:
            self = RemoeteErrors.notAuthenticated
        case 404:
            self = RemoeteErrors.notFound
        default:
            self = RemoeteErrors.notFound
        }
    }
}
extension RemoeteErrors: LocalizedError {
    
    var description: String? {
        switch self {
        case .notAuthenticated:
            return "You are not authrised to perform this request"
        case .notFound:
            return "Requested page not found"
        case .networkProblem:
            return "Unable to connect to server"
        case .requestFailed, .badRequest, .invalidData:
            return "Request faild. Please try again leter"
        }
    }
    
}
