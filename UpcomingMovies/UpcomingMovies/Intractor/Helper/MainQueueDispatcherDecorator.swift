//
//  MainQueueDispatcherDecorator.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 7/8/21.
//

import Foundation

final class MainQueueDispatcherDecorator: DataLoader {
    private let decoratee: DataLoader
    init(decoratee: DataLoader) {
        self.decoratee = decoratee
    }
    
    func load(from url: URL, resultHandler: @escaping (Data?, Error?) -> ()) {
        decoratee.load(from: url, resultHandler: { [weak self] viewModel, error in
            self?.pushToMainQueue(callback: {
                resultHandler(viewModel, nil)
            })
        })
    }
    
    func pushToMainQueue(callback: @escaping() -> ()){
        DispatchQueue.main.async {
            callback()
        }
    }
    
    
}
