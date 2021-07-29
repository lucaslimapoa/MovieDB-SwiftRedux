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
    @State private var shouldRefresh = true
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {                    
                    FeaturedContentListView(model: store.state.trending)
                    
                    ContentSectionView(header: "Popular Movies", model: store.state.popularMovies)

                    ContentSectionView(header: "Top Rated Movies", model: store.state.topRatedMovies)

                    ContentSectionView(header: "Popular TV Shows", model: store.state.popularTvShows)

                    ContentSectionView(header: "Top Rated TV Shows", model: store.state.topRatedTvShows)
                }
                .edgesIgnoringSafeArea(.horizontal)
            }
            .navigationBarTitle("TMDB Redux")
            .navigationBarTitleDisplayMode(.large)
            .onAppear(perform: fetchAll)
        }
    }
    
    private func fetchAll() {
        guard shouldRefresh else { return }
        
        [
            TrendingAction.fetch(),
            PopularMoviesAction.fetch(),
            TopRatedMoviesAction.fetch(),
            PopularTvShowsAction.fetch(),
            TopRatedTvShowsAction.fetch()
        ]
        .forEach(store.dispatch(action:))
        
        shouldRefresh = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(
            store: Store<AppState>(
                initialState: AppState(
                    trending: .loaded(fakeMovies),
                    popularMovies: .loaded(fakeMovies),
                    topRatedMovies: .error,
                    popularTvShows: .loading(nil)
                ),
                reducer: appReducer
            )
        )
    }
}
