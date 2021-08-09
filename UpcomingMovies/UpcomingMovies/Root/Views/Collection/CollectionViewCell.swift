//
//  CollectionViewCell.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/8/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var posterImageView: UIImageView = UIImageView()
    var ratingLabel: UILabel = UILabel()
    var titleLabel: UILabel = UILabel()
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
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setContraintsOnPosterImage() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor).isActive = true

    }
    private func setContraintsOnRatingLabel() {
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setContraintsOnTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
    }
}
