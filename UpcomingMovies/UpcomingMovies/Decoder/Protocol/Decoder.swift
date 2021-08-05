//
//  Decoder.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 3/8/21.
//

import Foundation

protocol DataDecoder {
    func decode<T:Decodable>(dataToBeDecoed data: Data) throws -> T 
}
