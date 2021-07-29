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
    private let store = Store(
        initialState: AppState(),
        reducer: appReducer,
        middleware: ThunkMiddleware()
    )
    
    var body: some Scene {
        WindowGroup {
            FeedView(store: store)
                .environmentObject(store)
        }
    }
}
