//
//  Actor.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 23.08.21.
//

import Foundation

struct Actor: Equatable, Identifiable {
    let id: String
    let name: String
    let avatarUrl: URL
}
