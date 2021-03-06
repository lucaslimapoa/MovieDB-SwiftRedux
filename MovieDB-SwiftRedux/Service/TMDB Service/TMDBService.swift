//
//  TMDBService.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 29.07.21.
//

import Foundation
import Combine

final class TMDBService: ContentService {
    private let session: URLSession
    private let apiKey: String
    private let baseURL = URL(string: "https://api.themoviedb.org/3")!
    private let jsonDecoder: JSONDecoder = .tmdbJsonDecoder
    
    init(session: URLSession = URLSession.shared, apiKey: String = "639a2c7eac5878745afcd2d2217be4bf") {
        self.session = session
        self.apiKey = apiKey
    }
    
    func content(query: ContentQuery) -> AnyPublisher<[Content], ContentServiceError> {
        guard let urlRequest = buildRequest(path: query.path) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        struct ContentResponse: Decodable {
            let results: [TMDBContent]
        }
        
        let response: AnyPublisher<ContentResponse, ContentServiceError> = requestPublisher(urlRequest: urlRequest)
        
        return response
            .map(\.results)
            .compactMap { $0.compactMap { $0.toContent(contentType: query.contentType) } }
            .eraseToAnyPublisher()
    }
    
    func credits(contentId: Int, contentType: ContentType) -> AnyPublisher<[Actor], ContentServiceError> {
        guard let urlRequest = buildRequest(path: contentType.path(id: contentId)) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        struct Response: Decodable {
            let cast: [TMDBActor]
        }
        
        let response: AnyPublisher<Response, ContentServiceError> = requestPublisher(urlRequest: urlRequest)
        
        return response
            .map(\.cast)
            .compactMap { $0.compactMap { $0.toActor() } }
            .eraseToAnyPublisher()
    }
    
    private func buildRequest(path: String) -> URLRequest? {
        URLBuilder()
            .with(baseURL: baseURL)
            .with(path: path)
            .with(apiKey: apiKey)
            .build()
    }
    
    private func requestPublisher<T>(urlRequest: URLRequest) -> AnyPublisher<T, ContentServiceError> where T: Decodable {
        session.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: jsonDecoder)
            .mapError(ContentServiceError.decodeFailed)
            .eraseToAnyPublisher()
    }
}

private extension ContentQuery {
    var path: String {
        switch self {
        case .trending:
            return "/trending/movie/week"
        case .popularMovies:
            return "/movie/popular"
        case .topRatedMovies:
            return "/movie/top_rated"
        case .popularTvShows:
            return "/tv/popular"
        case .topRatedTvShows:
            return "/tv/top_rated"
        }
    }
    
    var contentType: ContentType {
        switch self {
        case .popularMovies, .topRatedMovies, .trending:
            return .movie
        case .popularTvShows, .topRatedTvShows:
            return .tv
        }
    }
}

private extension ContentType {
    func path(id: Int) -> String {
        switch self {
        case .movie:
            return "/movie/\(id)/credits"
        case .tv:
            return "/tv/\(id)/credits"
        }
    }
}
