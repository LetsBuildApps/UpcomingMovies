//
//  UpcomingMoviesTests.swift
//  UpcomingMoviesTests
//
//  Created by CHARNPREET SINGH on 2/8/21.
//

import XCTest
@testable import UpcomingMovies

class UpcomingMoviesTests: XCTestCase {
    var mainStoryboard: UIStoryboard!
    var controller: MovieController!
    override func setUp() {
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        controller =  mainStoryboard.instantiateViewController(identifier: "movieController", creator: {coder in
            return MovieController(coder: coder, tableView: UITableView(frame: .zero, style: .plain))
        })
        super.setUp()
    }

    override func tearDown() {
        controller = nil
        mainStoryboard = nil
        super.tearDown()
    }
    
    func test_controller_tableView_has_dataSource() {
        controller.viewDidLoad()
        XCTAssertTrue(controller.tableView.dataSource != nil, "forget to set tableview for controller")
    }
    
    func test_tableView_has_RegisteredCell() {
        controller.viewDidLoad()
        XCTAssertTrue(controller.tableView.dequeueReusableCell(withIdentifier: "cell") != nil, "tableview has no cell register with identifer")
    }
}

class MovieController: UIViewController {
    var tableView: UITableView
    init?(coder: NSCoder, tableView: UITableView) {
        self.tableView  = tableView
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Please use another View Controller")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    
    private func loadMovies(using url: URL) {
        
    }
}


extension MovieController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
}

