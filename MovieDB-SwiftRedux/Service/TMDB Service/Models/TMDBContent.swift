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

extension TMDBContent {
    func toContent(contentType: ContentType) -> Content? {
        guard let title = title ?? name,
              let releaseDate = releaseDate ?? firstAirDate,
              let posterPath = posterPath,
              let posterURL = URL(string: "https://image.tmdb.org/t/p/w342\(posterPath)"),
              let backdropPath = backdropPath,
              let backdropURL = URL(string: "https://image.tmdb.org/t/p/w780\(backdropPath)"),
              let voteAverage = voteAverage else {
                  return nil
              }
        
        return Content(
            id: id,
            title: title,
            overview: overview,
            releaseDate: releaseDate,
            posterURL: posterURL,
            backdropURL: backdropURL,
            rating: String(format: "%.1f", voteAverage),
            contentType: contentType
        )
    }
}
