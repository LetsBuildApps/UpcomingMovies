//
//  Configurator.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/8/21.
//


import SDWebImage
protocol CellConfigurable {
    func configure(CellToBeConfigured cell: CollectionViewCell, with item: ViewModel)
}

struct CellConfigurator: CellConfigurable {
    func configure(CellToBeConfigured cell: CollectionViewCell, with item: ViewModel) {
        cell.posterImageView.sd_setImage(with: item.posterPath, placeholderImage: UIImage(named: "placeholder.png"))
        cell.titleLabel.text = item.title
        cell.ratingLabel.text = "\(item.rating)"
    }
}
