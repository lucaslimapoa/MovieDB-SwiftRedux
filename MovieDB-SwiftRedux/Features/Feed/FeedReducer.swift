//
//  FeedReducer.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 11.07.21.
//

import Foundation
import SwiftRedux

let feedReducer = Reducer<FeedState, FeedAction> { state, action in
    switch action {
    case .fetchSuccess(let movies):
        state.popularMovies = .loaded(movies)
    case .fetchError:
        state.popularMovies = .error
    case .fetchLoading:
        state.popularMovies = .loading(state.popularMovies.items)
    }
}
