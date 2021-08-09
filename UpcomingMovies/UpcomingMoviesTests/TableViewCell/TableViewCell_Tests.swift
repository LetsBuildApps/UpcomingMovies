//
//  TableViewCell_Tests.swift
//  UpcomingMoviesTests
//
//  Created by CHARNPREET SINGH on 7/8/21.
//

import XCTest

class CollectionViewCell_Tests: XCTestCase {

    var cell: CollectionViewCell!
    override func setUp() {
        cell = CollectionViewCell()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cell = nil
    }
    
    func test_cell_has_ImageView(){
        XCTAssertNotNil(cell.posterImageView, "poster ImageView is not intilized")
    }
    
    func test_Cell_has_RatingLabel(){
        XCTAssertNotNil(cell.ratingLabel, "rating label is not intilized")
    }
    func test_Cell_has_TitleLabel(){
        XCTAssertNotNil(cell.titleLabel, "title label is not intilized")
    }
    
    func test_Cell_has_SubViews() {
        XCTAssertTrue(!cell.subviews.isEmpty, "cell has no subviews")
    }
    func test_title_label_Added_As_A_Child() {
        XCTAssertEqual(cell.titleLabel.superview, cell.contentView, "title label is not inside the CollectionViewCell's content View")
    }
    func test_rating_label_Added_As_A_Child() {
        XCTAssertEqual(cell.ratingLabel.superview, cell.contentView, " rating label is not inside the CollectionViewCell's content View")
    }
    
    func test_posterImageView_Added_As_A_Child() {
        XCTAssertIdentical(cell.posterImageView.superview, cell.contentView, " posterImageView is not inside the CollectionViewCell's content View")
    }
}

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
