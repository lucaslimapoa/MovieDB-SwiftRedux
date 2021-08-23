//
//  CastReducerTests.swift
//  MovieDB-SwiftReduxTests
//
//  Created by Lucas Lima on 24.08.21.
//

import Combine
import SwiftRedux
import Foundation
@testable import MovieDB_SwiftRedux
import XCTest

class CastReducerTests: XCTestCase {
    var store: Store<AppState>!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        store = Store<AppState>(
            initialState: AppState(
                popularMovies: .loading(nil)
            ),
            reducer: CombinedReducer<AppState>
                .apply(reducer: CastReducer(), for: \.selectedContentCast),
            middleware: ThunkMiddleware()
        )
        cancellables = []
    }
    
    func testSuccessActionSetsSelectedContentCastToLoadedWithCast() {
        store.dispatch(action: CastAction.success(fakeCast))
        XCTAssertEqual(store.state.selectedContentCast, .loaded(fakeCast))
    }
    
    func testResetActionSetsSelectedContentCastToLoading() {
        store.dispatch(action: CastAction.reset)
        XCTAssertEqual(store.state.selectedContentCast, .loading(nil))
    }
    
    func testErrorActionSetsSelectedContentCastToError() {
        store.dispatch(action: CastAction.error)
        XCTAssertEqual(store.state.selectedContentCast, .error)
    }
    
    func testLoadingActionSetsSelectedContentCastToLoading() {
        store.dispatch(action: CastAction.loading)
        XCTAssertEqual(store.state.selectedContentCast, .loading(nil))
    }
    
    func testLoadingActionSetsSelectedContentCastToLoadingWithCastIfAlreadyExists() {
        store.dispatch(action: CastAction.success(fakeCast))
        store.dispatch(action: CastAction.loading)
        XCTAssertEqual(store.state.selectedContentCast, .loading(fakeCast))
    }
    
    func testFetchActionSetsSelectedContentCastToLoadingWhenItStarts() {
        let service = ContentServiceMock()
        service.creditsStub = Empty()
            .eraseToAnyPublisher()
        
        store.dispatch(action: CastAction.fetch(id: 0, contentType: .movie, service: service))
        
        XCTAssertEqual(store.state.selectedContentCast, .loading(nil))
    }
    
    func testFetchActionSucceedsSetsSelectedContentCastToLoaded() {
        let expectation = expectation(description: "should set to loaded")
        
        let service = ContentServiceMock()
        service.creditsStub = Just(fakeCast)
            .setFailureType(to: ContentServiceError.self)
            .eraseToAnyPublisher()
        
        store.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { _ in
                XCTAssertEqual(self.store.state.selectedContentCast, .loaded(fakeCast))
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        store.dispatch(action: CastAction.fetch(id: 0, contentType: .movie, service: service))
                
        waitForExpectations(timeout: 1)
    }
    
    func testFetchActionErrorsSetsSelectedContentCastToError() {
        let expectation = expectation(description: "should set to error")
        
        let service = ContentServiceMock()
        service.creditsStub = Fail(error: ContentServiceError.invalidURL)
            .eraseToAnyPublisher()
        
        store.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { _ in
                XCTAssertEqual(self.store.state.selectedContentCast, .error)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        store.dispatch(action: CastAction.fetch(id: 0, contentType: .movie, service: service))
                
        waitForExpectations(timeout: 1)
    }
}

private let fakeCast = [
    Actor(id: "1", name: "Morgan Freeman", avatarUrl: URL(string: "https://image.tmdb.org/t/p/w342/oIciQWr8VwKoR8TmAw1owaiZFyb.jpg")!),
]
