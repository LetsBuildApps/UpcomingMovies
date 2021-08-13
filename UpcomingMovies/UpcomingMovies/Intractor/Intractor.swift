//
//  Intractor.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 5/8/21.
//

import Foundation

struct URLPropertyHolder {
    var contentType: ContentType
    var currentPage: Int?
    var language: String? = "en"
    var apiKey: String = "0d9396afae9f4fe7bae0ce653bbee985"
    var path: Path
    var region: String?
    mutating func addOneToCurrentPageTotal(){
        self.currentPage? += 1
    }
}

class Intractor: Intractable {
    var decoder: DataDecoder
    var fetcher: DataLoader
    private var urlPropertyHolder:  URLPropertyHolder
    private var totalPages: Int = 0
    init(decoder: DataDecoder, fetcher: DataLoader, urlPropertyHolder: URLPropertyHolder) {
        self.decoder = decoder
        self.fetcher = fetcher
        self.urlPropertyHolder = urlPropertyHolder
    }

    
    fileprivate func constructURL() -> URL {
        return UpcomingMoviesEndPoints(path: urlPropertyHolder.path, section: urlPropertyHolder.contentType, apiKey:  urlPropertyHolder.apiKey, language: urlPropertyHolder.language, page: urlPropertyHolder.currentPage).url
    }
    fileprivate func updateCurrentPage() {
        urlPropertyHolder.addOneToCurrentPageTotal()
    }
    
    func getMovies<T:ViewModel>(callback: @escaping ([CellSection<T>]?, Error?) -> ()) {
        let url = constructURL()
        loadDataFromServer(using: url, callback: { [weak self] data, error in
            guard let data = data else {
                callback(nil,error)
                return
            }
            guard let expectedModel = self?.decodeDataThenUpdateTotalPages(dataToBeDecoder: data) else {
                self?.updateCurrentPage()
                callback(nil,error)
                return
            }
            guard let rows: [T] = self?.makeViewModel(from: expectedModel) else {
                callback(nil,error)
                return
            }
           let result = self?.makeCellSection(from: rows)
            self?.updateCurrentPage()
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
            print("failed To Decode Data in \(self) with error: \(error)")
        }
        return nil
    }
    
    fileprivate func updateTotalPagesCount(_ totalPagesCount: Int) {
        totalPages = totalPagesCount
    }
    
    private func makeRows<T:ViewModel>(from model: Movies) -> [T]{
        return makeViewModel(from: model)
    }
    private func makeCellSection<T:ViewModel>(from rows: [T]) -> [CellSection<T>] {
        return [CellSection(rows: rows)]
    }
    
    private func makeViewModel<T:ViewModel>(from model: Movies) -> [T] {
       return  model.results.map({UpcomingMovies(
                                    posterPath:PostersEndpoint(path: Poster.path.rawValue, host: Poster.host.rawValue, posterSize: .original, filePath: $0.posterPath ?? "").url,
                                     title: $0.title,
                                     release_date: $0.releaseDate,
                                    rating: $0.voteAverage) as! T})
     }
    
}
