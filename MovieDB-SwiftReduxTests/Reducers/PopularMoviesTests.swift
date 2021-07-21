//
//  FeedReducerTests.swift
//  FeedReducerTests
//
//  Created by Lucas Lima on 20.07.21.
//

import Combine
@testable import MovieDB_SwiftRedux
import SwiftRedux
import XCTest

class PopularMoviesTests: XCTestCase {
    var store: Store<LoadableModel<[Movie]>>!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        store = Store<LoadableModel<[Movie]>>(
            initialState: .loading(nil),
            reducer: popularMovies,
            middleware: [.thunkMiddleware]
        )
        cancellables = []
    }
    
    func testFeedActionFetchSuccessSetsPopularMoviesStateToLoadedWithMovies() {
        store.dispatch(action: PopularMoviesAction.success(fakeMovies))
        XCTAssertEqual(store.state, .loaded(fakeMovies))
    }
    
    func testFeedActionFetchErrorSetsPopularMoviesStateToError() {
        store.dispatch(action: PopularMoviesAction.error)
        XCTAssertEqual(store.state, .error)
    }
    
    func testFeedActionFetchLoadingSetsPopularMoviesStateToLoading() {
        store.dispatch(action: PopularMoviesAction.loading)
        XCTAssertEqual(store.state, .loading(nil))
    }
    
    func testFeedActionFetchPopularMoviesInitiatedSetsStateToLoading() {
        let service = MovieServiceMock()
        service.trendingStub = Empty(completeImmediately: true)
            .eraseToAnyPublisher()
        
        store.dispatch(action: PopularMoviesAction.fetch(service: service))

        XCTAssertEqual(store.state, .loading(nil))
    }
    
    func testFeedActionFetchPopularMoviesSuccessSetsStateToLoaded() {
        let expectation = expectation(description: "should set state to loaded")
        
        let service = MovieServiceMock()
        service.trendingStub = Just<[Movie]>(fakeMovies)
            .setFailureType(to: MovieServiceError.self)
            .eraseToAnyPublisher()
        
        store.$state
            .dropFirst(2)
            .sink { newState in
                XCTAssertEqual(newState, .loaded(fakeMovies))
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        store.dispatch(action: PopularMoviesAction.fetch(service: service))
                
        waitForExpectations(timeout: 1)
    }
    
    func testFeedActionFetchPopularMoviesErrorSetsStateToError() {
        let expectation = expectation(description: "should set state to loaded")
        
        let service = MovieServiceMock()
        service.trendingStub = Fail(error: MovieServiceError.invalidURL)
            .eraseToAnyPublisher()
        
        store.$state
            .dropFirst(2)
            .sink { newState in
                XCTAssertEqual(newState, .error)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        store.dispatch(action: PopularMoviesAction.fetch(service: service))
                
        waitForExpectations(timeout: 1)
    }
}

private final class MovieServiceMock: MovieService {
    var trendingStub: AnyPublisher<[Movie], MovieServiceError>?
    func popular() -> AnyPublisher<[Movie], MovieServiceError> {
        guard let trendingStub = trendingStub else { fatalError("trendingStub not configured") }
        return trendingStub
    }
}

private let fakeMovies = [
    Movie(
        id: 0,
        title: "title",
        overview: "some overview",
        releaseDate: nil,
        isAdult: nil,
        backdropPath: nil,
        genreIds: nil,
        voteCount: nil,
        voteAverage: nil,
        mediaType: nil,
        posterPath: nil
    )
]
