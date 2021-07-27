//
//  AppReducer.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 11.07.21.
//

import Foundation
import SwiftRedux

let appReducer = CombinedReducer<AppState>
    .apply(reducer: PopularMovies(), for: \.popularMovies)
