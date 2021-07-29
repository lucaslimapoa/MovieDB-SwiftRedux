//
//  ContentService.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 11.07.21.
//

import Combine

enum ContentQuery {
    case trending
    case popularMovies
    case topRatedMovies
    case popularTvShows
    case topRatedTvShows
}

enum ContentServiceError: Error {
    case invalidURL
    case decodeFailed(wrapped: Error)
}

protocol ContentService {
    func content(query: ContentQuery) -> AnyPublisher<[Content], ContentServiceError>
}
