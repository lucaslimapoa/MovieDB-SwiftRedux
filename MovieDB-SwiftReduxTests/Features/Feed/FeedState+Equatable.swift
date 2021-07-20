//
//  FeedState+Equatable.swift
//  FeedState+Equatable
//
//  Created by Lucas Lima on 20.07.21.
//

@testable import MovieDB_SwiftRedux

extension FeedState: Equatable {
    public static func == (lhs: FeedState, rhs: FeedState) -> Bool {
        switch (lhs.trendingMovies, rhs.trendingMovies) {
        case (.loading(let lhsLoading), .loading(let rhsLoading)):
            return lhsLoading == rhsLoading
        case (.loaded(let lhsLoaded), .loaded(let rhsLoaded)):
            return lhsLoaded == rhsLoaded
        case (.error, .error):
            return true
        default:
            return false
        }
    }
}
