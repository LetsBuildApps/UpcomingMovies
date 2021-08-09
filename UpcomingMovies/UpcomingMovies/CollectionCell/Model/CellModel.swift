//
//  CellModel.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/8/21.
//

import UIKit

protocol CellViewModel {
    var posterImg: UIImage? {get set}
    var title: String {get set}
    var release_date: String {get set}
    var rating: Double {get set}
}

struct CellModel: CellViewModel {
    var posterImg: UIImage?
    var title: String
    var release_date: String
    var rating: Double
    
}
