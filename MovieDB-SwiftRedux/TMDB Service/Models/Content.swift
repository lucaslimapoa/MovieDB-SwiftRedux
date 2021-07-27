//
//  Movie.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 11.07.21.
//

import Foundation

struct Content: Decodable, Equatable {
    let id: Int
    let title: String?
    let name: String?
    let overview: String
    let releaseDate: Date?
    let firstAirDate: Date?
    let isAdult: Bool?
    let backdropPath: TMDBImageURL?
    let voteCount: Int?
    let voteAverage: Double?
    let posterPath: TMDBImageURL?
}

@propertyWrapper
struct TMDBImageURL: Decodable, Equatable {
    var wrappedValue: URL

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringURL = try container.decode(String.self)
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w342\(stringURL)") else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Not possible to create URL from \(stringURL)"
                )
            )
        }
        
        wrappedValue = url
    }
}
