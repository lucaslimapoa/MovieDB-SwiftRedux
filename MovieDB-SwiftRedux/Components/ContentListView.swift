//
//  ContentListView.swift
//  ContentListView
//
//  Created by Lucas Lima on 21.07.21.
//

import SwiftUI
import Kingfisher

struct ContentListView: View {
    let content: [Content]
    @State var horizontalInset: CGFloat? = nil
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer(minLength: horizontalInset ?? 16)
             
                LazyHStack(alignment: .top, spacing: 12) {
                    ForEach(content, id: \.id) { content in
                        VStack(alignment: .leading, spacing: 4) {
                            if let posterURL = content.posterPath {
                                KFImage.url(posterURL.wrappedValue)
                                    .placeholder { placeholderImage(shouldShowProgress: true) }
                                    .fade(duration: 0.35)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 145)
                                    .cornerRadius(4)
                            } else {
                                placeholderImage(shouldShowProgress: false)
                            }
                            
                            if let title = content.title ?? content.name {
                                Text(title)
                                    .foregroundColor(.primary)
                                    .font(.system(size: 13, weight: .medium))
                                    .lineLimit(2)
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            
                            let date = content.releaseDate ?? content.firstAirDate
                            
                            date.map {
                                Text($0, formatter: DateFormatter.mediumDate)
                                    .foregroundColor(.secondary)
                                    .font(.system(size: 11, weight: .regular))
                            }
                        }
                        .frame(width: 105)
                    }
                }
                
                Spacer(minLength: horizontalInset ?? 16)
            }
        }
    }
    
    private func placeholderImage(shouldShowProgress: Bool) -> some View {
        ZStack {
            Color.clear

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
            ContentListView(
                content: .fakeMovies
            )
            .preferredColorScheme(.dark)
            
            ContentListView(
                content: .fakeMovies
            )
            .preferredColorScheme(.light)
        }
    }
}
