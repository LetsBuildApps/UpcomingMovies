//
//  Intractable.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 6/8/21.
//

import Foundation

protocol Intractable {
    func getMovies(callback: @escaping ([Section]?, Error?)->())
}
