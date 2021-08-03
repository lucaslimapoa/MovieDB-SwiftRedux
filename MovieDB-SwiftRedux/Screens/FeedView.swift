//
//  ContentView.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 11.07.21.
//

import SwiftUI
import SwiftRedux

struct FeedView: View {
    @UseDispatch<AnyAction> private var dispatch
    
    @SelectState(\AppState.trending) private var trending
    @SelectState(\AppState.popularMovies) private var popularMovies
    @SelectState(\AppState.topRatedMovies) private var topRatedMovies
    @SelectState(\AppState.popularTvShows) private var popularTvShows
    @SelectState(\AppState.topRatedTvShows) private var topRatedTvShows
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    FeaturedContentListView(model: trending)
                    ContentSectionView(header: "Popular Movies", model: popularMovies)
                    ContentSectionView(header: "Top Rated Movies", model: topRatedMovies)
                    ContentSectionView(header: "Popular TV Shows", model: popularTvShows)
                    ContentSectionView(header: "Top Rated TV Shows", model: topRatedTvShows)
                }
                .edgesIgnoringSafeArea(.horizontal)
            }
            .navigationBarTitle("TMDB Redux")
            .navigationBarTitleDisplayMode(.large)
            .onAppear(perform: fetchAll)
        }
    }
    
    private func fetchAll() {
        [
            TrendingAction.fetch(),
            PopularMoviesAction.fetch(),
            TopRatedMoviesAction.fetch(),
            PopularTvShowsAction.fetch(),
            TopRatedTvShowsAction.fetch()
        ]
        .forEach { dispatch(action: $0) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
            .store(
                Store<AppState>(
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
