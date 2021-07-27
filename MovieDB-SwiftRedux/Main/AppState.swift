//
//  AppState.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 11.07.21.
//

import Foundation

struct AppState: Equatable {
    var popularMovies: LoadableModel<[Content]> = .loading(nil)
    var topRatedMovies: LoadableModel<[Content]> = .loading(nil)
    var popularTvShows: LoadableModel<[Content]> = .loading(nil)
    var topRatedTvShows: LoadableModel<[Content]> = .loading(nil)
}
