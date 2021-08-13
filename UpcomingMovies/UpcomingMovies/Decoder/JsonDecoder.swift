//
//  JsonDecoder.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 3/8/21.
//

import Foundation

struct JsonDecoder: DataDecoder {
    func decode<T>(dataToBeDecoed data: Data) throws -> T where T : Decodable {
        if data.isEmpty {
            throw DecodingErrors.dataSetEmpty
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        }catch let DecodingError.keyNotFound(key, _) {
            print(key.stringValue)
            throw DecodingErrors.keyIsMissing(key: key.stringValue)
        } catch  DecodingError.typeMismatch(_, _) {
            throw DecodingErrors.typeMisMatch
        }catch DecodingError.valueNotFound(_, _) {
            
            throw DecodingErrors.valueNotFound
        } catch DecodingError.dataCorrupted(_) {
            throw DecodingErrors.invalidData
        }
    }
    
    
}
