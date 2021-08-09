//
//  PosterEndPoint.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/8/21.
//

import Foundation

struct PostersEndpoint: EndPoint {
    var path: String
    var host: String
    var filePath: String
    var posterSize: PosterSize
    var url: URL {
        var components = URLComponents()
        components.host = host
        components.scheme =  "https"
        components.path = "\(path)\(posterSize.rawValue)/\(filePath)"
        guard let url = components.url else {
            preconditionFailure("invalid url component")
        }
        return url
    }

    internal init(path: String, host: String, posterSize: PosterSize, filePath: String) {
        self.path = path
        self.host = host
        self.posterSize = posterSize
        self.filePath = filePath
    }
}
