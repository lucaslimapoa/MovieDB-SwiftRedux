//
//  URLBuilder.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 11.07.21.
//

import Foundation

final class URLBuilder {
    private var baseURL: URL?
    private var path: String?
    private var apiKey: String?
    
    func with(baseURL: URL) -> Self {
        self.baseURL = baseURL
        return self
    }
    
    func with(path: String) -> Self {
        self.path = path
        return self
    }
    
    func with(apiKey: String) -> Self {
        self.apiKey = apiKey
        return self
    }
    
    func build() -> URLRequest? {
        guard let baseURL = baseURL,
              let path = path,
              let apiKey = apiKey else { return nil }
        
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        guard let url = components?.url else { return nil }
        
        return URLRequest(url: url)
    }
}
