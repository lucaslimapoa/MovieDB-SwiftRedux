//
//  Movie.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 11.07.21.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let overview: String
    let releaseDate: Date?
    let isAdult: Bool?
    let backdropPath: String?
    let genreIds: [GenreID]?
    let voteCount: Int?
    let voteAverage: Double?
    let mediaType: MediaType?
}
