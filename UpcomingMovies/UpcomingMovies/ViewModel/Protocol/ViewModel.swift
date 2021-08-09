//
//  ViewModel.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 6/8/21.
//

import Foundation
/*
 * view model protcol is what a view is expecting
 */
protocol ViewModel {
    var posterPath: URL {get set}
    var title: String {get set}
    var release_date: String {get set}
    var rating: Double {get set}
}
