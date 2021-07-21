//
//  MovieService+JSONDecoder.swift
//  MovieService+JSONDecoder
//
//  Created by Lucas Lima on 21.07.21.
//

import Foundation

extension JSONDecoder {
    static var tmdbJsonDecoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            guard let date = dateFormatter.date(from: dateString) else {
                throw DecodingError.dataCorruptedError(in: container,
                    debugDescription: "Cannot decode date string \(dateString)")
            }
            
            return date
        }
        return jsonDecoder
    }
}
