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
        ZStack {
            Color("background")
            
            VStack {
                switch store.state.popularMovies {
                case .loading(let items):
                    loading(items: items)
                case .loaded(let items):
                    loaded(movies: items)
                case .error:
                    Text("Error")
                        .foregroundColor(.red)
                }
            }
            .onAppear { store.dispatch(action: FeedAction.fetchPopularMovies()) }
        }
        .edgesIgnoringSafeArea(.all)
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
    static var emptyReducer: Reducer<FeedState, FeedAction> {
        Reducer<FeedState, FeedAction> { _, _ in }
    }
    
    static var previews: some View {
        Group {
            FeedView(
                store: Store<FeedState>(
                    initialState: FeedState(popularMovies: .loading(nil)),
                    reducer: emptyReducer
                )
            )
            
            FeedView(
                store: Store<FeedState>(
                    initialState: FeedState(popularMovies: .loaded([])),
                    reducer: emptyReducer
                )
            )
            
            FeedView(
                store: Store<FeedState>(
                    initialState: FeedState(popularMovies: .error),
                    reducer: emptyReducer
                )
            )
        }
    }
}
