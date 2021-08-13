//
//  SceneDelegate.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 2/8/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let layout  = createCompositionalLayout()
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //        let vc = mainStoryboard.instantiateViewController(identifier: "collectionController", creator: {coder in
        //            let holder = URLPropertyHolder( contentType: .movies, currentPage: 1, language: "en", apiKey: "0d9396afae9f4fe7bae0ce653bbee985", path: .upcoming)
        //           let intractor = Intractor(decoder: JsonDecoder(), fetcher: MainQueueDispatcherDecorator(decoratee: RemoteFetcherService()), urlPropertyHolder: holder)
        //            return CollectionController<UpcomingMovies>(coder: coder, cellConfigurator: CellConfigurator(), intractor: intractor, layout:layout)
        //        })
        let holder = URLPropertyHolder( contentType: .movies, currentPage: 1, language: "en", apiKey: "0d9396afae9f4fe7bae0ce653bbee985", path: .upcoming)
        let intractor = Intractor(decoder: JsonDecoder(), fetcher: MainQueueDispatcherDecorator(decoratee: RemoteFetcherService()), urlPropertyHolder: holder)
        let vc = CollectionController<UpcomingMovies>(cellConfigurator: CellConfigurator(), intractor: intractor, layout:layout)
        window?.rootViewController = vc
    }
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize) 
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        // let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let group =  NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        let section = NSCollectionLayoutSection(group: group)
        // section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0)
        // section.orthogonalScrollingBehavior = .groupPaging
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

