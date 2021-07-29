//
//  Content.swift
//  Content
//
//  Created by Lucas Lima on 29.07.21.
//

import Foundation

struct Content: Equatable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: Date
    let posterURL: URL
    let backdropURL: URL
}

extension Content {
    init?(tmdbContent: TMDBContent) {
        guard let title = tmdbContent.title ?? tmdbContent.name,
              let releaseDate = tmdbContent.releaseDate ?? tmdbContent.firstAirDate,
              let posterPath = tmdbContent.posterPath,
              let posterURL = URL(string: "https://image.tmdb.org/t/p/w342\(posterPath)"),
              let backdropPath = tmdbContent.backdropPath,
              let backdropURL = URL(string: "https://image.tmdb.org/t/p/w780\(backdropPath)") else {
                  return nil
              }
        self.init(id: tmdbContent.id, title: title, overview: tmdbContent.overview, releaseDate: releaseDate, posterURL: posterURL, backdropURL: backdropURL)
    }
}
