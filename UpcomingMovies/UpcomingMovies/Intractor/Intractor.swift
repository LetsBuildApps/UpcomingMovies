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
    private var url: URL
    private var currentPage: Int = 1
    private var totalPages: Int = 0
    init(decoder: DataDecoder, fetcher: DataLoader, url: URL) {
        self.decoder = decoder
        self.fetcher = fetcher
        self.url = url
    }
    
    func getMovies(callback: @escaping ([Section]?, Error?) -> ()) {
        loadDataFromServer(using: url, callback: { [weak self]data, error in
            guard let data = data else {
                callback(nil,error)
                return
            }
            guard let expectedModel = self?.decodeDataThenUpdateTotalPages(dataToBeDecoder: data) else {
                callback(nil,error)
                return
            }
           let result = self?.makeCellSection(from: expectedModel)
            callback(result, nil)
        })
    }
    
    private func loadDataFromServer(using url: URL,  callback: @escaping (Data?, Error?) -> ()){
        fetcher.load(from: url, resultHandler: { data, error in
            guard let data = data else {
                callback(nil,error)
                return
            }
             callback(data, nil)
        })
    }
    private func decodeDataThenUpdateTotalPages(dataToBeDecoder data: Data) -> Movies? {
        do {
            let v: Movies = try decoder.decode(dataToBeDecoed: data)
            updateTotalPagesCount(v.totalPages)
            return v
        } catch let error {
            print("failed To Decode Data here \(self) with error: \(error)")
        }
        return nil
    }
    
    fileprivate func updateTotalPagesCount(_ totalPagesCount: Int) {
        totalPages = totalPagesCount
    }
    
    
    private func makeCellSection(from model: Movies) -> [Section] {
        let rows = makeViewModel(from: model)
        let section : [CellSection] = [CellSection(rows: rows)]
        return section
    }
    
    private func makeViewModel(from model: Movies) -> [ViewModel] {
       return  model.results.map({UpcomingMovies(
                                     posterPath:PostersEndpoint(path: Poster.path.rawValue, host: Poster.host.rawValue, posterSize: .original, filePath: $0.posterPath).url,
                                     title: $0.title,
                                     release_date: $0.releaseDate,
                                     rating: $0.voteAverage)})
     }
    
}
