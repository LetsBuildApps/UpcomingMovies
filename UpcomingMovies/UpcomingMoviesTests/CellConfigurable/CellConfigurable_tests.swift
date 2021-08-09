//
//  CellConfigurable_tests.swift
//  UpcomingMoviesTests
//
//  Created by CHARNPREET SINGH on 9/8/21.
//
//
import XCTest
@testable import UpcomingMovies
class CellConfigurable_tests: XCTestCase {

    var cellConfigurator: CellConfigurable!
    var  cell: CollectionViewCell!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cellConfigurator = CellConfigurator()
        cell = CollectionViewCell()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cellConfigurator = nil
    }
    
    func test_Can_Configure_Cell() {
        
        cellConfigurator.configure(CellToBeConfigured: cell, with: CellModel(posterImg: UIImage(named: "test_icon"), title: "F9", release_date: "29/03/2021", rating: 2.6))
        XCTAssertNotNil(cell.titleLabel.text, "title Labal has no text set up")
        XCTAssertNotNil(cell.ratingLabel.text, "rating Labal has no text set up")
        XCTAssertNotNil(cell.posterImageView.image, "poster imageview has no image set up")
    }
    
}


