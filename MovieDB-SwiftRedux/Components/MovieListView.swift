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
    @State var horizontalInset: CGFloat? = nil
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer(minLength: horizontalInset ?? 16)
             
                LazyHStack(alignment: .top, spacing: 12) {
                    ForEach(movies, id: \.id) { movie in
                        VStack(alignment: .leading) {
                            if let posterURL = movie.posterPath {
                                KFImage.url(posterURL.wrappedValue)
                                    .placeholder { placeholderImage(shouldShowProgress: true) }
                                    .fade(duration: 0.35)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 160)
                                    .cornerRadius(4)
                            } else {
                                placeholderImage(shouldShowProgress: false)
                            }
                            
                            Text(movie.title)
                                .foregroundColor(.primary)
                                .font(.system(size: 13, weight: .medium))
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            movie.releaseDate.map {
                                Text($0, formatter: DateFormatter.mediumDate)
                                    .foregroundColor(.secondary)
                                    .font(.system(size: 11, weight: .regular))
                            }
                        }
                        .frame(width: 120)
                    }
                }
                
                Spacer(minLength: horizontalInset ?? 16)
            }
        }
    }
    
    private func placeholderImage(shouldShowProgress: Bool) -> some View {
        ZStack {
            Color.gray

            if shouldShowProgress {
                ProgressView()
            }
        }
        .frame(height: 160)
        .cornerRadius(4)
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
