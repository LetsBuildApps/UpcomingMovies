//
//  FetcherAPI.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 3/8/21.
//

import Foundation

protocol DataLoader {
    func load(from url: URL, resultHandler: @escaping(Data?, Error?)-> ())
}
