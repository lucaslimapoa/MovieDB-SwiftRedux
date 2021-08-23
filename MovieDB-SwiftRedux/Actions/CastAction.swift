//
//  CastAction.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 23.08.21.
//

import Foundation
import SwiftRedux

enum CastAction {
    case success([Actor])
    case error
    case loading
    case reset
    
    static func fetch(id: Int, contentType: ContentType, service: ContentService = TMDBService()) -> ThunkPublisher<AppState> {
        ThunkPublisher { store in
            store.dispatch(action: loading)
            return service.credits(contentId: id, contentType: contentType)
                .receive(on: DispatchQueue.main)
                .map(success)
                .replaceError(with: error)
                .eraseToAnyPublisher()
        }
    }
}
