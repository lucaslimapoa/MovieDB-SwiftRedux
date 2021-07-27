//
//  FeedAction.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 19.07.21.
//

import SwiftUI
import Combine
import SwiftRedux

enum PopularMovies { }
enum TopRatedMovies { }
enum PopularTvShows { }
enum TopRatedTvShows { }

typealias PopularMoviesAction = ContentAction<PopularMovies>
typealias TopRatedMoviesAction = ContentAction<TopRatedMovies>
typealias PopularTvShowsAction = ContentAction<PopularTvShows>
typealias TopRatedTvShowsAction = ContentAction<TopRatedTvShows>

enum ContentAction<Type> {
    case success([Content])
    case error
    case loading
    
    private static func fetch(query: ContentQuery, service: ContentService) -> ThunkPublisher<AppState> {
        ThunkPublisher { store in
            store.dispatch(action: loading)
            return service.content(query: query)
                .receive(on: DispatchQueue.main)
                .map(success)
                .replaceError(with: error)
                .eraseToAnyPublisher()
        }
    }
}

extension ContentAction where Type == PopularMovies {
    static func fetch(service: ContentService = TMDBService()) -> ThunkPublisher<AppState> {
        fetch(query: .popularMovies, service: service)
    }
}

extension ContentAction where Type == TopRatedMovies {
    static func fetch(service: ContentService = TMDBService()) -> ThunkPublisher<AppState> {
        fetch(query: .topRatedMovies, service: service)
    }
}

extension ContentAction where Type == PopularTvShows {
    static func fetch(service: ContentService = TMDBService()) -> ThunkPublisher<AppState> {
        fetch(query: .popularTvShows, service: service)
    }
}

extension ContentAction where Type == TopRatedTvShows {
    static func fetch(service: ContentService = TMDBService()) -> ThunkPublisher<AppState> {
        fetch(query: .topRatedTvShows, service: service)
    }
}
