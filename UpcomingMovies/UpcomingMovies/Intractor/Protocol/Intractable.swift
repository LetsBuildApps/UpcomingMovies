//
//  Intractable.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 6/8/21.
//

import Foundation

protocol Intractable {
    func loadMovies(using url: URL, callback: @escaping ([ViewModel]?, Error?)->())
    func loadImagePosters(using url: URL, callBack: @escaping (Data?, Error?) -> ())
}
