//
//  RootReducer.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 11.07.21.
//

import Foundation
import SwiftRedux

let rootReducer = CombinedReducer<AppState>
    .apply(reducer: popularMovies, for: \.popularMovies)
