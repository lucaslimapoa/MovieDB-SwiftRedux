//
//  Movie+Equatable.swift
//  Movie+Equatable
//
//  Created by Lucas Lima on 20.07.21.
//

@testable import MovieDB_SwiftRedux

extension Movie: Equatable {
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
}
