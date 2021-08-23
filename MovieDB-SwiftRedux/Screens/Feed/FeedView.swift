//
//  ContentView.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 11.07.21.
//

import SwiftUI
import SwiftRedux

struct FeedView: View {
    @Dispatch<AnyAction> private var dispatch
    @SelectState(\AppState.trending) private var trending
    @SelectState(mapToSections) private var sections
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    FeaturedContentListView(model: trending)
                    ForEach(sections, id: \.header) { section in
                        ContentSectionView(header: section.header, model: section.model)
                    }
                }
                .edgesIgnoringSafeArea(.horizontal)
            }
            .navigationBarTitle("TMDB Redux")
            .navigationBarTitleDisplayMode(.large)
            .onLoad(perform: fetchAll)
        }
        .accentColor(.white)
    }
    
    private static func mapToSections(state: AppState) -> [Section] {
        [
            Section(header: "Popular Movies", model: state.popularMovies),
            Section(header: "Top Rated Movies", model: state.topRatedMovies),
            Section(header: "Popular TV Shows", model: state.popularTvShows),
            Section(header: "Top Rated TV Shows", model: state.topRatedTvShows)
        ]
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

private struct Section {
    let header: String
    let model: LoadableModel<[Content]>
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
