//
//  CastReducer.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 24.08.21.
//

import Foundation
import SwiftRedux

struct CastReducer: Reducer {
    func reduce(state: inout LoadableModel<[Actor]>, action: CastAction) {
        switch action {
        case .success(let cast):
            state = .loaded(cast)
        case .error:
            state = .error
        case .loading:
            state = .loading(state.items)
        case .reset:
            state = .loading(nil)
        }
    }
}
