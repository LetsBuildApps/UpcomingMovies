//
//  CollectionViewCell.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/8/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    let posterImageView: UIImageView = UIImageView()
    let ratingLabel: UILabel = UILabel()
    let titleLabel: UILabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
       addSubviews(subViewToBeAdded: [posterImageView, ratingLabel, titleLabel]) //
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews(subViewToBeAdded: [posterImageView, ratingLabel, titleLabel])
    }
    
    private func addSubviews(subViewToBeAdded subViews: [UIView]) {
        for view in subViews {
            self.contentView.addSubview(view)
        }
    }
    
}
