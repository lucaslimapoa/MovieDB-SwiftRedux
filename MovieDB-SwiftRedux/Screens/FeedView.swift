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
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    ContentSectionView(header: "Popular Movies", model: store.state.popularMovies)
                        .onAppear { store.dispatch(action: PopularMoviesAction.fetch()) }
                    
                    ContentSectionView(header: "Top Rated Movies", model: store.state.topRatedMovies)
                        .onAppear { store.dispatch(action: TopRatedMoviesAction.fetch()) }
                    
                    ContentSectionView(header: "Popular TV Shows", model: store.state.popularTvShows)
                        .onAppear { store.dispatch(action: PopularTvShowsAction.fetch()) }
                    
                    ContentSectionView(header: "Top Rated TV Shows", model: store.state.topRatedTvShows)
                        .onAppear { store.dispatch(action: TopRatedTvShowsAction.fetch()) }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .edgesIgnoringSafeArea(.horizontal)
            }
            .navigationBarTitle("TMDB Redux")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

private struct ContentSectionView: View {
    let header: String
    let model: LoadableModel<[Content]>
    
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
                    .font(.body)
                    .frame(maxWidth: .infinity, minHeight: 135, alignment: .center)
                
            case let .loaded(movies):
                ContentListView(content: movies)
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
                    popularMovies: .loaded(.fakeMovies),
                    topRatedMovies: .error,
                    popularTvShows: .loading(nil)
                ),
                reducer: appReducer
            )
        )
    }
}
