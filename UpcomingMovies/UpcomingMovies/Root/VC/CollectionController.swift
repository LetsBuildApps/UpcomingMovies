//
//  ViewController.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 2/8/21.
//

import UIKit
class CollectionController<T: ViewModel>: UICollectionViewController, UICollectionViewDataSourcePrefetching {
    fileprivate var cellConfigurator: CellConfigurable
    fileprivate var intractor: Intractable
//    fileprivate var sections: [Section] = []
    fileprivate var sections: [CellSection<T>] = []
    fileprivate var layout: UICollectionViewCompositionalLayout
    //MARK: - initlizer properties
    init(cellConfigurator: CellConfigurable, intractor: Intractable, layout: UICollectionViewCompositionalLayout) {
        self.cellConfigurator = cellConfigurator
        self.intractor = intractor
        self.layout = layout
        super.init(collectionViewLayout: layout)
      //  super.init(nibName: nil, bundle: nil)

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
    private var dataSource: DataSource!
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = makeDataSource()
        configureCollectionView()
        getMovies()
    }

    typealias DataSource = UICollectionViewDiffableDataSource<CellSection<T>, T>
    func makeDataSource() -> DataSource {
      // 1
      let dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, movies) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {return UICollectionViewCell()}
            self.cellConfigurator.configure(CellToBeConfigured: cell, with: movies)
            return cell
      })
      return dataSource
    }
    typealias Snapshot = NSDiffableDataSourceSnapshot<CellSection<T>, T>
    func applySnapshot(animatingDifferences: Bool = true) {
      var snapshot = Snapshot()
        snapshot.appendSections(sections)
        sections.forEach { section in
            snapshot.appendItems(section.rows, toSection: section)
        }
      dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    fileprivate func configureCollectionView() {
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.prefetchDataSource = self
        self.collectionView.collectionViewLayout = layout
        self.collectionView.dataSource = dataSource
    }
    

    fileprivate func getMovies() {
        intractor.getMovies(callback: {(result:[CellSection<T>]?, error) in
            guard let result = result else {
                print(error as Any)
                return
            }
            self.sections.append(contentsOf: result.map({$0}))
            self.applySnapshot()
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let video = dataSource.itemIdentifier(for: indexPath) else {
//          return
//        }
    }
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.item == sections[indexPath.section].rows.count - 5 {
                getMovies()
            }
        }
    }
}

