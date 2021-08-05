//
//  Enpoints.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 5/8/21.
//

import Foundation

protocol EndPoint {
    var path: Path {get}
    var section: Section {get}
    var apiKey: String {get}
    var language: String? {get}
    var page: Int? {get}
    var region: String? {get}
    var queryItems: [URLQueryItem] {get}
    var url: URL {get}
}
