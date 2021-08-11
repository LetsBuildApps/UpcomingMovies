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
    //MARK: - initlizer properties
    init(cellConfigurator: CellConfigurable, intractor: Intractable) {
        self.cellConfigurator = cellConfigurator
        self.intractor = intractor
        super.init(nibName: nil, bundle: nil)
    }
    
    //MARK: - initlizer with coder and properties
    init?(coder: NSCoder, cellConfigurator: CellConfigurable, intractor: Intractable) {
        self.cellConfigurator = cellConfigurator
        self.intractor = intractor
        super.init(coder: coder)
    }
    /*
     * controller should just tell intractor get me movies thats
     * viewModel Should have section count as well
     */
    required init?(coder: NSCoder) {
        cellConfigurator = CellConfigurator()
        let c = UpcomingMoviesEndPoints(path: .upcoming, section: .movies, apiKey: "0d9396afae9f4fe7bae0ce653bbee985", language: "en", page: 1)
        self.intractor = Intractor(decoder: JsonDecoder(), fetcher: MainQueueDispatcherDecorator(decoratee: RemoteFetcherService()), url: c.url)
        super.init(coder: coder)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.collectionViewLayout = createCompositionalLayout()
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.prefetchDataSource = self
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
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
     }
}

extension CollectionController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row > sections[indexPath.section].rows.count - 2 {
                //getMovies()
            }
        }
    }
}



