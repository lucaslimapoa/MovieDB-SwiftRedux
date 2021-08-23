//
//  AppReducer.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 11.07.21.
//

import Foundation
import SwiftRedux

let appReducer = CombinedReducer<AppState>
    .apply(reducer: ContentReducer<Trending>(), for: \.trending)
    .apply(reducer: ContentReducer<PopularMovies>(), for: \.popularMovies)
    .apply(reducer: ContentReducer<TopRatedMovies>(), for: \.topRatedMovies)
    .apply(reducer: ContentReducer<PopularTvShows>(), for: \.popularTvShows)
    .apply(reducer: ContentReducer<TopRatedTvShows>(), for: \.topRatedTvShows)
    .apply(reducer: CastReducer(), for: \.selectedContentCast)
