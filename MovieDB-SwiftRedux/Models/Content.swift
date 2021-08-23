//
//  Content.swift
//  Content
//
//  Created by Lucas Lima on 29.07.21.
//

import Foundation

enum ContentType {
    case movie
    case tv
}

struct Content: Equatable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: Date
    let posterURL: URL
    let backdropURL: URL
    let rating: String
    let contentType: ContentType
}
