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
protocol ViewModel:Hashable {
    var id : UUID{get set}
    var posterPath: URL {get set}
    var title: String {get set}
    var release_date: String {get set}
    var rating: Double {get set}
}
//: Hashable, Equatable
extension ViewModel  {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.posterPath == rhs.posterPath && lhs.title == rhs.title && lhs.release_date == rhs.release_date && lhs.rating == rhs.rating && lhs.id == rhs.id
       }
       func hash(into hasher: inout Hasher) {
         hasher.combine(rating)
        hasher.combine(posterPath)
        hasher.combine(title)
        hasher.combine(release_date)
        hasher.combine(id)
       }
}


