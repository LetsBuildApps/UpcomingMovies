//
//  Intractor.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 5/8/21.
//

import Foundation
class Intractor: Intractable {
    var decoder: DataDecoder
    var fetcher: DataLoader
    init(decoder: DataDecoder, fetcher: DataLoader) {
        self.decoder = decoder
        self.fetcher = fetcher
    }
    
    
    func loadData(using url: URL, callback: @escaping ([ViewModel]?) -> ()) {
        loadDataFromRemoteFetcher(from: url, callback: { viewModel, error in
            callback(viewModel)
        })
    }
    
  private func loadDataFromRemoteFetcher(from url: URL,  callback: @escaping ([ViewModel]?, Error?) -> ()) {
        fetcher.load(from: url, resultHandler: { data, error in
            guard let data = data else {
                callback(nil,error)
                return
            }
            let result =  self.decodeData(dataToBeDecoder: data)
             callback(result, nil)
        })
    }
    
  private func decodeData(dataToBeDecoder data: Data) -> [ViewModel]? {
        do {
            let v: Movies = try decoder.decode(dataToBeDecoed: data)
            return makeViewModel(from: v)
        } catch let error {
            print("failed here \(self) with error: \(error)")
        }
        return nil
    }
    
   private func makeViewModel(from model: Movies) -> [ViewModel] {
      return  model.results.map({UpcomingMovies(posterPath: $0.posterPath, title: $0.title, release_date: $0.releaseDate, rating: $0.voteAverage)})
    }
}
