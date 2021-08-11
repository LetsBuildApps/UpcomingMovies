//
//  CollectionViewCell.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/8/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var posterImageView: UIImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
       addSubviews(subViewToBeAdded: [posterImageView]) //
        posterImageView.layer.cornerRadius = 10
        posterImageView.layer.borderWidth = 3
        posterImageView.layer.borderColor = UIColor.black.cgColor
        posterImageView.layer.shadowColor = UIColor.white.cgColor
        posterImageView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        posterImageView.layer.shadowRadius = 12.0
        posterImageView.layer.shadowOpacity = 0.7
        posterImageView.layer.masksToBounds = true
        posterImageView.contentMode = .scaleAspectFit
        
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews(subViewToBeAdded: [posterImageView])
       
    }
    
    private func addSubviews(subViewToBeAdded subViews: [UIView]) {
        for view in subViews {
            self.contentView.addSubview(view)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setContraintsOnPosterImage()
       
    }
    
    private func setContraintsOnPosterImage() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true

    }
}
