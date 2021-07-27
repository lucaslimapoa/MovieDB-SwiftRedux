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
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    MoviesSectionView(header: "Popular Movies", model: store.state.popularMovies)
                        .onAppear { store.dispatch(action: PopularMoviesAction.fetch()) }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .edgesIgnoringSafeArea(.horizontal)
            }
            .navigationBarTitle("TMDB Redux")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

private struct MoviesSectionView: View {
    let header: String
    let model: LoadableModel<[Movie]>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(header)
                .foregroundColor(.primary)
                .font(.headline)
                .padding(.horizontal)
            
            switch model {
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
        .frame(minHeight: 240, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(
            store: Store<AppState>(
                initialState: AppState(
                    popularMovies: .loaded(.fakeMovies)
                ),
                reducer: appReducer
            )
        )
    }
}
