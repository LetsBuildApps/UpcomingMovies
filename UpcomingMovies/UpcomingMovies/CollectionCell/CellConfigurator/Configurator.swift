//
//  Configurator.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/8/21.
//

import Foundation

protocol CellConfigurable {
    func configure(CellToBeConfigured cell: CollectionViewCell, with item: CellViewModel)
}

struct CellConfigurator: CellConfigurable {
    func configure(CellToBeConfigured cell: CollectionViewCell, with item: CellViewModel) {
        cell.posterImageView.image = item.posterImg
        cell.titleLabel.text = item.title
        cell.ratingLabel.text = "\(item.rating)"
    }
}
