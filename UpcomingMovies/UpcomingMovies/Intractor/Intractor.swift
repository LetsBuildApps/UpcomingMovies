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
    
    func loadImagePosters(using url: URL, callBack: @escaping (Data?, Error?) -> ()) {
        fetcher.load(from: url, resultHandler: { data, error in
            callBack(data, error)
        })
    }
    
    func loadMovies(using url: URL, callback: @escaping ([ViewModel]?, Error?) -> ()) {
        loadDataFromRemoteFetcher(from: url, callback: {viewModel, error in
            callback(viewModel, error)
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
            print("failed To Decode Data here \(self) with error: \(error)")
        }
        return nil
    }
    
   private func makeViewModel(from model: Movies) -> [ViewModel] {
      return  model.results.map({UpcomingMovies(
                                    posterPath:PostersEndpoint(path: Poster.path.rawValue, host: Poster.host.rawValue, posterSize: .original, filePath: $0.posterPath).url,
                                    title: $0.title,
                                    release_date: $0.releaseDate,
                                    rating: $0.voteAverage)})
    }
}
