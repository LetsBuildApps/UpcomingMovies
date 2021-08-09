//
//  Endpoints.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 4/8/21.
//

import Foundation

struct QueryItems {
    var apiKey: String
    var language: String?
    var page: Int?
    var region: String?
}

struct UpcomingMoviesEndPoints: EndPoint {
    var url: URL {
        var components = URLComponents()
        components.host = "api.themoviedb.org"
        components.scheme =  "https"
        components.path = "/3/\(section.rawValue)/\(path.rawValue)"
        components.queryItems = queryItems
        guard let url = components.url else {
            preconditionFailure("invalid url component")
        }
        return url
    }
    
    var path: Path
    var section: Section
    var apiKey: String
    var language: String?
    var page: Int?
    var region: String?
    var queryItems: [URLQueryItem] = []
    
    internal init(path: Path, section: Section, apiKey: String, language: String? = nil, page: Int? = nil, region: String? = nil) {
        self.path = path
        self.section = section
        self.apiKey = apiKey
        self.language = language
        self.page = page
        self.region = region
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: language),
            URLQueryItem(name: "page", value: "\(page ?? 1)"),
            URLQueryItem(name: "region", value: region)
        ]
        self.queryItems = makeURLQueryItems(queryItems: queryItems)
    }
    
    private func makeURLQueryItems(queryItems: [URLQueryItem]) -> [URLQueryItem] {
        var newURLQueryItem: [URLQueryItem] = []
        for item in queryItems {
            if item.value != nil {
                newURLQueryItem.append(item)
            }
        }
        return newURLQueryItem
    }
}

