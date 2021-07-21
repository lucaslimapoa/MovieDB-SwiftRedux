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
        let store = Store<AppState>(
            initialState: AppState(),
            reducer: rootReducer,
            middleware: [
                .thunkMiddleware
            ]
        )
        
        return WindowGroup {
            FeedView(store: store)
                .environmentObject(store)
        }
    }
}
