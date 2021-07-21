//
//  ContentView.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 11.07.21.
//

import SwiftUI
import SwiftRedux

struct FeedView: View {
    @ObservedObject var store: Store<AppState>
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 16) {
            popularMoviesSection(store: store.scope(state: \.popularMovies))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
    }
    
    private func popularMoviesSection(store: Store<LoadableModel<[Movie]>>) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Popular Movies")
                .foregroundColor(.primary)
                .font(.headline)
            
            switch store.state {
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, minHeight: 135, alignment: .center)
            case .error:
                Text("Something went wrong")
                    .foregroundColor(.primary)
                    .font(.largeTitle)
            case let .loaded(movies):
                MovieListView(movies: movies)
            }
        }
        .onAppear { store.dispatch(action: PopularMoviesAction.fetch()) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(
            store: Store<AppState>(
                initialState: AppState(),
                reducer: rootReducer
            )
        )
    }
}
