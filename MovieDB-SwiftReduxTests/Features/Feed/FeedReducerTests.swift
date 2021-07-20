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
    
    func testFeedActionFetchSuccessSetsTrendingMoviesStateToLoadedWithMovies() {
        store.dispatch(action: FeedAction.fetchSuccess(fakeMovies))
        XCTAssertEqual(store.state, FeedState(trendingMovies: .loaded(fakeMovies)))
    }
    
    func testFeedActionFetchErrorSetsTrendingMoviesStateToError() {
        store.dispatch(action: FeedAction.fetchError)
        XCTAssertEqual(store.state, FeedState(trendingMovies: .error))
    }
    
    func testFeedActionFetchLoadingSetsTrendingMoviesStateToLoading() {
        store.dispatch(action: FeedAction.fetchLoading)
        XCTAssertEqual(store.state, FeedState(trendingMovies: .loading(nil)))
    }
    
    func testFeedActionFetchTrendingMoviesInitiatedSetsStateToLoading() {
        let service = MovieServiceMock()
        service.trendingStub = Empty(completeImmediately: true)
            .eraseToAnyPublisher()
        
        store.dispatch(action: FeedAction.fetchTrendingMovies(service: service))

        XCTAssertEqual(store.state, FeedState(trendingMovies: .loading(nil)))
    }
    
    func testFeedActionFetchTrendingMoviesSuccessSetsStateToLoaded() {
        let expectation = expectation(description: "should set state to loaded")
        
        let service = MovieServiceMock()
        service.trendingStub = Just<[Movie]>(fakeMovies)
            .setFailureType(to: MovieServiceError.self)
            .eraseToAnyPublisher()
        
        store.$state
            .dropFirst(2)
            .sink { newState in
                XCTAssertEqual(newState, FeedState(trendingMovies: .loaded(fakeMovies)))
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        store.dispatch(action: FeedAction.fetchTrendingMovies(service: service))
                
        waitForExpectations(timeout: 1)
    }
    
    func testFeedActionFetchTrendingMoviesErrorSetsStateToError() {
        let expectation = expectation(description: "should set state to loaded")
        
        let service = MovieServiceMock()
        service.trendingStub = Fail(error: MovieServiceError.invalidURL)            
            .eraseToAnyPublisher()
        
        store.$state
            .dropFirst(2)
            .sink { newState in
                XCTAssertEqual(newState, FeedState(trendingMovies: .error))
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        store.dispatch(action: FeedAction.fetchTrendingMovies(service: service))
                
        waitForExpectations(timeout: 1)
    }
}

private final class MovieServiceMock: MovieService {
    var trendingStub: AnyPublisher<[Movie], MovieServiceError>?
    func trending(mediaType: MediaType, timeWindow: TimeWindow) -> AnyPublisher<[Movie], MovieServiceError> {
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
        mediaType: nil
    )
]
