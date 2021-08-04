//
//  Endpoints.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 4/8/21.
//

import Foundation
struct UpcomingMoviesEndPoints {
    var path: String
    var section: Section
    var apiKey: String
    var language: String?
    var page: Int?
    var region: String?
    var queryItems: [URLQueryItem]

    var url: URL {
        var components = URLComponents()
        components.host = "api.themoviedb.org"
        components.scheme =  "https"
        components.path = "/3/\(section.rawValue)/\(path)"
        components.queryItems = queryItems
        print(queryItems)
        guard let url = components.url else {
            preconditionFailure("invalid url component")
        }
        return url
    }
    
    enum Section: String {
        case movies = "movie"
        case tv = "tv"
    }
    
    internal init(path: String, section: UpcomingMoviesEndPoints.Section, apiKey: String, language: String? = nil, page: Int? = nil, region: String? = nil) {
        self.path = path
        self.section = section
        self.apiKey = apiKey
        self.language = language
        self.page = page
        self.region = region
        let queryItems: [String: String?] = [
            "api_key": apiKey,
            "language": language,
            "page": "\(page ?? 1)",
            "region": region
        ]
        
        self.queryItems = queryItems.compactMapValues({$0}).map({URLQueryItem(name: $0.key, value: $0.value)})
         
    }
}

