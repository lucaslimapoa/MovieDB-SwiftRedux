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

class FeedReducerTests: XCTestCase {
    var store: Store<FeedState>!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        store = Store<FeedState>(
            initialState: FeedState(),
            reducer: feedReducer,
            middleware: [.thunkMiddleware]
        )
        cancellables = []
    }
    
    func testFeedActionFetchSuccessSetsPopularMoviesStateToLoadedWithMovies() {
        store.dispatch(action: FeedAction.fetchSuccess(fakeMovies))
        XCTAssertEqual(store.state, FeedState(popularMovies: .loaded(fakeMovies)))
    }
    
    func testFeedActionFetchErrorSetsPopularMoviesStateToError() {
        store.dispatch(action: FeedAction.fetchError)
        XCTAssertEqual(store.state, FeedState(popularMovies: .error))
    }
    
    func testFeedActionFetchLoadingSetsPopularMoviesStateToLoading() {
        store.dispatch(action: FeedAction.fetchLoading)
        XCTAssertEqual(store.state, FeedState(popularMovies: .loading(nil)))
    }
    
    func testFeedActionFetchPopularMoviesInitiatedSetsStateToLoading() {
        let service = MovieServiceMock()
        service.trendingStub = Empty(completeImmediately: true)
            .eraseToAnyPublisher()
        
        store.dispatch(action: FeedAction.fetchPopularMovies(service: service))

        XCTAssertEqual(store.state, FeedState(popularMovies: .loading(nil)))
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
                XCTAssertEqual(newState, FeedState(popularMovies: .loaded(fakeMovies)))
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        store.dispatch(action: FeedAction.fetchPopularMovies(service: service))
                
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
                XCTAssertEqual(newState, FeedState(popularMovies: .error))
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        store.dispatch(action: FeedAction.fetchPopularMovies(service: service))
                
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
