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
    func popular() -> AnyPublisher<[Movie], MovieServiceError>
}

final class MovieDbService: MovieService {
    private let session: URLSession
    private let apiKey: String
    private let baseURL = URL(string: "https://api.themoviedb.org/3")!
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            guard let date = dateFormatter.date(from: dateString) else {
                throw DecodingError.dataCorruptedError(in: container,
                    debugDescription: "Cannot decode date string \(dateString)")
            }
            
            return date
        }
        return jsonDecoder
    }()
    
    init(session: URLSession = URLSession.shared, apiKey: String = "639a2c7eac5878745afcd2d2217be4bf") {
        self.session = session
        self.apiKey = apiKey
    }
    
    func popular() -> AnyPublisher<[Movie], MovieServiceError> {
        guard let request = URLBuilder()
            .with(baseURL: baseURL)
            .with(path: "movie/popular")
            .with(apiKey: apiKey)
                .build() else { return Fail(error: .invalidURL).eraseToAnyPublisher() }
        
        struct MovieResponse: Decodable {
            let results: [Movie]
        }
        
        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: jsonDecoder)
            .mapError { .decodeFailed(wrapped: $0) }
            .map(\.results)
            .eraseToAnyPublisher()
    }
}
