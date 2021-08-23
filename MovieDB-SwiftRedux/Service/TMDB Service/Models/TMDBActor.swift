//
//  Actor.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 23.08.21.
//

import Foundation

struct TMDBActor: Decodable {
    let adult: Bool?
    let gender: Int?
    let knownForDepartment: String?
    let name: String?
    let originalName: String?
    let popularity: Double?
    let profilePath: URL?
    let castId: Int?
    let character: String?
    let creditId: String?
    let order: Int?
}

extension TMDBActor {
    func toActor() -> Actor? {
        guard let name = name,
              let profilePath = profilePath,
              let avatarUrl = URL(string: "https://image.tmdb.org/t/p/w342\(profilePath)"),
              let castId = castId else {
            return nil
        }
        
        return Actor(
            id: String(castId),
            name: name,
            avatarUrl: avatarUrl
        )
    }
}
