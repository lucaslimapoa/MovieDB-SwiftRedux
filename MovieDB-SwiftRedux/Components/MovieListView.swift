//
//  MovieListView.swift
//  MovieListView
//
//  Created by Lucas Lima on 21.07.21.
//

import SwiftUI
import Kingfisher

struct MovieListView: View {
    let movies: [Movie]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(movies, id: \.id) { movie in
                    VStack(alignment: .leading) {
                        if let posterURL = movie.posterPath {
                            KFImage.url(posterURL.wrappedValue)
                                .placeholder {
                                    ZStack {
                                        Color.gray
                                        
                                        ProgressView()
                                            .foregroundColor(.white)
                                    }
                                }
                                .fade(duration: 0.35)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 135)
                                .cornerRadius(8)
                        } else {
                            Color.gray
                                .frame(width: .infinity, height: 135)
                                .cornerRadius(8)
                        }
                        
                        Text(movie.title)
                            .foregroundColor(.primary)
                            .font(.system(size: 12, weight: .medium))
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        movie.releaseDate.map {
                            Text($0, formatter: DateFormatter.mediumDate)
                                .foregroundColor(.secondary)
                                .font(.system(size: 10, weight: .regular))
                        }
                    }
                    .frame(width: 100)
                }
            }
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieListView(
                movies: .fakeMovies
            )
            .preferredColorScheme(.dark)
            
            MovieListView(
                movies: .fakeMovies
            )
            .preferredColorScheme(.light)
        }
    }
}
