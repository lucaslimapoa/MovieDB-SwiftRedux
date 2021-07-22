//
//  AppState.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 11.07.21.
//

import Foundation

struct AppState {
    var popularMovies: LoadableModel<[Movie]> = .loading(nil)
}