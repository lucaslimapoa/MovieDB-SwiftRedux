//
//  FeedAction.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 19.07.21.
//

import SwiftUI
import Combine
import SwiftRedux

enum PopularMoviesAction {
    case success([Movie])
    case error
    case loading
    
    static func fetch(service: MovieService = TMDBService()) -> ThunkPublisher<AppState> {
        ThunkPublisher { store in
            store.dispatch(action: loading)
            return service.popularMovies()
                .receive(on: DispatchQueue.main)
                .map(success)
                .replaceError(with: error)
                .eraseToAnyPublisher()
        }
    }
}
