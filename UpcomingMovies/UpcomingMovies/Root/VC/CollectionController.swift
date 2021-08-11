//
//  ViewController.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 2/8/21.
//

import UIKit
class CollectionController: UICollectionViewController {
    fileprivate var cellConfigurator: CellConfigurable
    fileprivate var intractor: Intractable
    fileprivate var sections: [Section] = []
    fileprivate var layout: UICollectionViewCompositionalLayout
    //MARK: - initlizer properties
    init(cellConfigurator: CellConfigurable, intractor: Intractable, layout: UICollectionViewCompositionalLayout) {
        self.cellConfigurator = cellConfigurator
        self.intractor = intractor
        self.layout = layout
        super.init(nibName: nil, bundle: nil)

    }
    
    //MARK: - initlizer with coder and properties
    init?(coder: NSCoder, cellConfigurator: CellConfigurable, intractor: Intractable, layout: UICollectionViewCompositionalLayout ) {
        self.cellConfigurator = cellConfigurator
        self.intractor = intractor
        self.layout = layout
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Please use other intilizers")
    }

    fileprivate func getMovies() {
        intractor.getMovies(callback: {result, error in
            guard let result = result else {
                print(error as Any)
                return
            }
            self.sections.append(contentsOf: result.map({$0}))
            self.collectionView.reloadData()
        })
    }
    
    fileprivate func configureCollectionView() {
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.prefetchDataSource = self
        self.collectionView.collectionViewLayout = layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        getMovies()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {return UICollectionViewCell()}
        
        let movies = self.sections[indexPath.section].rows[indexPath.row]
        cellConfigurator.configure(CellToBeConfigured: cell, with: movies)
        return cell
    }
    
}

extension CollectionController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row > sections[indexPath.section].rows.count - 2 {
                getMovies()
            }
        }
    }
}



