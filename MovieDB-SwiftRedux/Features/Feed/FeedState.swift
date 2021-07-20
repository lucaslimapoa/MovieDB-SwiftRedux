//
//  FeedState.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 11.07.21.
//

import Foundation

struct FeedState {
    var popularMovies: LoadableModel<Movie> = .loading(nil)
}
