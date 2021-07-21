//
//  FeedReducer.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 11.07.21.
//

import Foundation
import SwiftRedux

let popularMovies = Reducer<LoadableModel<[Movie]>, PopularMoviesAction> { state, action in
    switch action {
    case .success(let movies):
        state = .loaded(movies)
    case .error:
        state = .error
    case .loading:
        state = .loading(state.items)
    }
}
