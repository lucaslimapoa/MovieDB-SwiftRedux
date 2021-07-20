//
//  FeedAction.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 19.07.21.
//

import SwiftUI
import Combine
import SwiftRedux

enum FeedAction: Action {
    case fetchSuccess([Movie])
    case fetchError
    case fetchLoading
    
    static func fetchPopularMovies(service: MovieService = MovieDbService()) -> ThunkActionPublisher<FeedState> {
        ThunkActionPublisher<FeedState> { store in
            service.popular()
                .handleEvents(receiveSubscription: { _ in
                    store.dispatch(fetchLoading)
                })
                .receive(on: DispatchQueue.main)
                .map(fetchSuccess)
                .catch { error -> AnyPublisher<Action, Never> in
                    print(error.localizedDescription)
                    return Just(fetchError)
                        .eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
        }
    }
}
