//
//  ContentServiceMock.swift
//  MovieDB-SwiftReduxTests
//
//  Created by Lucas Lima on 24.08.21.
//

@testable import MovieDB_SwiftRedux
import Combine

final class ContentServiceMock: ContentService {
    var creditsStub: AnyPublisher<[Actor], ContentServiceError>?
    var contentStub: AnyPublisher<[Content], ContentServiceError>?
    
    func content(query: ContentQuery) -> AnyPublisher<[Content], ContentServiceError> {
        guard let contentStub = contentStub else { fatalError("contentStub not configured") }
        return contentStub
    }
    
    func credits(contentId: Int, contentType: ContentType) -> AnyPublisher<[Actor], ContentServiceError> {
        guard let creditsStub = creditsStub else { fatalError("creditsStub not configured") }
        return creditsStub
    }
}
