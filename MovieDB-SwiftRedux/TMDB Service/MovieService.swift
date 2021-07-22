//
//  MovieService.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 11.07.21.
//

import Foundation
import Combine

enum MovieServiceError: Error {
    case invalidURL
    case decodeFailed(wrapped: Error)
}

protocol MovieService {
    func popularMovies() -> AnyPublisher<[Movie], MovieServiceError>
}

final class TMDBService: MovieService {
    private let session: URLSession
    private let apiKey: String
    private let baseURL = URL(string: "https://api.themoviedb.org/3")!
    private let jsonDecoder: JSONDecoder = .tmdbJsonDecoder
    
    init(session: URLSession = URLSession.shared, apiKey: String = "639a2c7eac5878745afcd2d2217be4bf") {
        self.session = session
        self.apiKey = apiKey
    }
    
    private func buildRequest(path: String) -> URLRequest? {
        URLBuilder()
            .with(baseURL: baseURL)
            .with(path: path)
            .with(apiKey: apiKey)
            .build()
    }
    
    private func request<T>(urlRequest: URLRequest, response: T.Type) -> AnyPublisher<T, MovieServiceError> where T: Decodable {
        session.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: jsonDecoder)
            .mapError { .decodeFailed(wrapped: $0) }
            .eraseToAnyPublisher()
    }
    
    func popularMovies() -> AnyPublisher<[Movie], MovieServiceError> {
        guard let urlRequest = buildRequest(path: "movie/popular") else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        struct MovieResponse: Decodable {
            let results: [Movie]
        }
        
        return request(urlRequest: urlRequest, response: MovieResponse.self)
            .map(\.results)
            .eraseToAnyPublisher()
    }
}
