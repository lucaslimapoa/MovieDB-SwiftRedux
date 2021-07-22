//
//  FeedAction.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 19.07.21.
//

import SwiftUI
import Combine
import SwiftRedux

enum PopularMoviesAction: Action {
    case success([Movie])
    case error
    case loading
    
    static func fetch(service: MovieService = MovieDbService()) -> ThunkPublisher<AppState> {
        ThunkPublisher { store in
            service.popular()
                .handleEvents(
                    receiveSubscription: { _ in
                        store.dispatch(loading)
                    }
                )
                .receive(on: DispatchQueue.main)
                .map(success)
                .replaceError(with: error)
                .eraseToAnyPublisher()
        }
    }
}
