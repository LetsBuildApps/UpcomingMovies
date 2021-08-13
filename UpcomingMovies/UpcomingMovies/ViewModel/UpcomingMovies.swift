//
//  UpcomingMoviesViewModel.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 4/8/21.
//

import Foundation
/// will be used by UpcomingMovies ViewHandler
struct UpcomingMovies: ViewModel {
    var posterPath: URL
    var title: String
    var release_date: String
    var rating: Double
    var id : UUID = UUID()
    internal init(posterPath: URL, title: String, release_date: String, rating: Double) {
        self.posterPath = posterPath
        self.title = title
        self.release_date = release_date
        self.rating = rating
    }
    
}
struct CellSection<T: ViewModel>: Hashable {
    var id : UUID = UUID()
    static func == (lhs: CellSection<T>, rhs: CellSection<T>) -> Bool {
        return lhs.rows == rhs.rows && lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(rows)
        hasher.combine(id)
    }
    var rows: [T]
}

