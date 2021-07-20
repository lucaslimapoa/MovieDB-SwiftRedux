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
        state.trendingMovies = .loaded(movies)
    case .fetchError:
        state.trendingMovies = .error
    case .fetchLoading:
        state.trendingMovies = .loading(state.trendingMovies.items)
    }
}
