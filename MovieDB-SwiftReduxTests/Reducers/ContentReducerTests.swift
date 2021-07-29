//
//  ContentReducerTests.swift
//  ContentReducerTests
//
//  Created by Lucas Lima on 20.07.21.
//

import Combine
@testable import MovieDB_SwiftRedux
import SwiftRedux
import XCTest

class ContentReducerTests: XCTestCase {
    var store: Store<AppState>!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        store = Store<AppState>(
            initialState: AppState(
                popularMovies: .loading(nil)
            ),
            reducer: CombinedReducer<AppState>
                .apply(reducer: ContentReducer<PopularMovies>(), for: \.popularMovies),
            middleware: ThunkMiddleware()
        )
        cancellables = []
    }
    
    func testFeedActionFetchSuccessSetsPopularMoviesStateToLoadedWithMovies() {
        store.dispatch(action: PopularMoviesAction.success(fakeMovies))
        XCTAssertEqual(store.state.popularMovies, .loaded(fakeMovies))
    }
    
    func testFeedActionFetchErrorSetsPopularMoviesStateToError() {
        store.dispatch(action: PopularMoviesAction.error)
        XCTAssertEqual(store.state.popularMovies, .error)
    }
    
    func testFeedActionFetchLoadingSetsPopularMoviesStateToLoading() {
        store.dispatch(action: PopularMoviesAction.loading)
        XCTAssertEqual(store.state.popularMovies, .loading(nil))
    }
    
    func testFeedActionFetchPopularMoviesInitiatedSetsStateToLoading() {
        let service = ContentServiceMock()
        service.contentStub = Empty(completeImmediately: true)
            .eraseToAnyPublisher()
        
        store.dispatch(action: PopularMoviesAction.fetch(service: service))

        XCTAssertEqual(store.state.popularMovies, .loading(nil))
    }
    
    func testFeedActionFetchPopularMoviesSuccessSetsStateToLoaded() {
        let expectation = expectation(description: "should set state to loaded")
        
        let service = ContentServiceMock()
        service.contentStub = Just<[Content]>(fakeMovies)
            .setFailureType(to: ContentServiceError.self)
            .eraseToAnyPublisher()
        
        store.objectWillChange
            .receive(on: DispatchQueue.main) // Add a TestStore that can improve this behavior.
            .sink { _ in
                XCTAssertEqual(self.store.state.popularMovies, .loaded(fakeMovies))
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        store.dispatch(action: PopularMoviesAction.fetch(service: service))
                
        waitForExpectations(timeout: 1)
    }
    
    func testFeedActionFetchPopularMoviesErrorSetsStateToError() {
        let expectation = expectation(description: "should set state to loaded")
        
        let service = ContentServiceMock()
        service.contentStub = Fail(error: ContentServiceError.invalidURL)
            .eraseToAnyPublisher()
        
        store.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { _ in
                XCTAssertEqual(self.store.state.popularMovies, .error)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        store.dispatch(action: PopularMoviesAction.fetch(service: service))
                
        waitForExpectations(timeout: 1)
    }
}

private final class ContentServiceMock: ContentService {
    var contentStub: AnyPublisher<[Content], ContentServiceError>?
    func content(query: ContentQuery) -> AnyPublisher<[Content], ContentServiceError> {
        guard let contentStub = contentStub else { fatalError("trendingStub not configured") }
        return contentStub
    }
}

private let fakeMovies = [
    Content(
        id: 0,
        title: "title",
        releaseDate: Date(),
        posterURL: URL(string: "https://image.tmdb.org/t/p/w185_and_h278_bestv2/9E2y5Q7WlCVNEhP5GiVTjhEhx1o.jpg")!,
        backdropURL: URL(string: "https://image.tmdb.org/t/p/w185_and_h278_bestv2/9E2y5Q7WlCVNEhP5GiVTjhEhx1o.jpg")!
    )
]
