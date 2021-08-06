//
//  Intractor.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 5/8/21.
//

import Foundation

class Intractor: Intractable{
    var decoder: DataDecoder
    var fetcher: DataLoader
    init(decoder: DataDecoder, fetcher: DataLoader) {
        self.decoder = decoder
        self.fetcher = fetcher
    }
    func loadData(using url: URL, callback: @escaping ([ViewModel]?) -> ()) {
        loadDataFromAPI(from: url, callback: {viewModel in
            callback(viewModel)
        })
    }
    
  private func loadDataFromAPI(from url: URL,  callback: @escaping ([ViewModel]?) -> ()) {
        fetcher.load(from: url, resultHandler: { data, error in
            guard let data = data else {return}
            let result =  self.loadDataFromDecoder(dataToBeDecoder: data)
            callback(result)
        })
    }
  private func loadDataFromDecoder(dataToBeDecoder data: Data) -> [ViewModel]? {
        do {
            let v: UpcomingMovies = try decoder.decode(dataToBeDecoed: data)
            return buildViewModels(from: v)
        } catch let error {
            print(error)
        }
        return nil
    }
    
   private func buildViewModels(from model: UpcomingMovies) -> [ViewModel] {
      return  model.results.map({UpcomingMoviesViewModel(posterPath: $0.posterPath, title: $0.title, release_date: $0.releaseDate, rating: $0.voteAverage)})
    }
}
