//
//  ContentView.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 11.07.21.
//

import SwiftUI
import SwiftRedux

struct FeedView: View {
    @ObservedObject var store: Store<FeedState>
    
    var body: some View {
        VStack {
            switch store.state.trendingMovies {
            case .loading(let items):
                loading(items: items)
            case .loaded(let items):
                loaded(movies: items)
            case .error:
                Text("Error")
                    .foregroundColor(.red)
            }
        }
        .onAppear { store.dispatch(action: FeedAction.fetchTrendingMovies()) }
    }
    
    private func loading(items: [Movie]?) -> some View {
        Text("Loading")
    }
    
    private func loaded(movies: [Movie]) -> some View {
        VStack {
            ScrollView {
                ForEach(movies, id: \.id) { movie in
                    Text(movie.overview)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let previewStore = Store<AppState>(
            initialState: AppState(),
            reducer: rootReducer,
            middleware: [
                .thunkMiddleware
            ]
        )
        
        FeedView(store: previewStore.scope(state: \.feedState))
    }
}
