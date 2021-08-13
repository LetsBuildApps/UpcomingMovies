//
//  Configurator.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/8/21.
//


import SDWebImage
protocol CellConfigurable {
//    func configure(CellToBeConfigured cell: CollectionViewCell, with item: ViewModel)
    func configure<T:ViewModel>(CellToBeConfigured cell: CollectionViewCell, with item: T)
}

struct CellConfigurator: CellConfigurable {
//    func configure(CellToBeConfigured cell: CollectionViewCell, with item: ViewModel) {
//        cell.posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
//        cell.posterImageView.sd_imageTransition = .fade
//        cell.posterImageView.sd_setImage(with: item.posterPath, placeholderImage: nil)
//    }
    
    func configure<T:ViewModel>(CellToBeConfigured cell: CollectionViewCell, with item: T) {
        cell.posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.posterImageView.sd_imageTransition = .fade
        cell.posterImageView.sd_setImage(with: item.posterPath, placeholderImage: nil)
    }
}
