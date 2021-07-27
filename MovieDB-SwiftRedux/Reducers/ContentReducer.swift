//
//  MoviesReducer.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 11.07.21.
//

import Foundation
import SwiftRedux

struct ContentReducer<T>: Reducer {
    func reduce(state: inout LoadableModel<[Content]>, action: ContentAction<T>) {
        switch action {
        case .success(let movies):
            state = .loaded(movies)
        case .error:
            state = .error
        case .loading:
            state = .loading(state.items)
        }
    }
}
