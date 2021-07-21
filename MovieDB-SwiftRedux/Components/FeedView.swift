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
        ZStack {
            Color("background")
            
            VStack {
                EmptyView()
            }
            .onAppear { store.dispatch(action: PopularMoviesAction.fetch()) }
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
    static var previews: some View {
        FeedView(
            store: Store<AppState>(
                initialState: AppState(),
                reducer: rootReducer
            )
        )
    }
}
