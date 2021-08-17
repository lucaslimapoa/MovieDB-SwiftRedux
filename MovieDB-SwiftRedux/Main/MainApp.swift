//
//  MovieDBApp.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 11.07.21.
//

import SwiftUI
import SwiftRedux

@main
struct MainApp: App {
    var body: some Scene {
        WindowGroup {
            FeedView()
                .store(
                    Store(
                        initialState: AppState(),
                        reducer: appReducer,
                        middleware: CombinedMiddleware
                            .apply(LoggingMiddleware())
                            .apply(ThunkMiddleware())
                    )
                )
        }
    }
}
