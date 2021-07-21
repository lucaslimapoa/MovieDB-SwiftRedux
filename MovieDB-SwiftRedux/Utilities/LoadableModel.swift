//
//  LoadableModel.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 19.07.21.
//

import Foundation

enum LoadableModel<T> {
    case loading(T?)
    case loaded(T)
    case error
}

extension LoadableModel where T: Collection {
    var items: T? {
        switch self {
        case .loaded(let items):
            return items
        case .loading(let items):
            return items
        case .error:
            return nil
        }
    }
}
