//
//  TMDBContent.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 11.07.21.
//

import Foundation

struct TMDBContent: Decodable, Equatable {
    let id: Int
    let title: String?
    let name: String?
    let overview: String
    let releaseDate: Date?
    let firstAirDate: Date?
    let isAdult: Bool?
    let backdropPath: String?
    let voteCount: Int?
    let voteAverage: Double?
    let posterPath: String?
}
