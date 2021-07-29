//
//  ContentListView.swift
//  ContentListView
//
//  Created by Lucas Lima on 21.07.21.
//

import SwiftUI

struct ContentListView: View {
    private enum Constants {
        static let itemWidth: CGFloat = 105
        static let posterHeight: CGFloat = 145
        static let defaultInset: CGFloat = 16
    }
    
    let content: [Content]
    @State var horizontalInset: CGFloat? = nil
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer(minLength: horizontalInset ?? Constants.defaultInset)
             
                LazyHStack(alignment: .top, spacing: 12) {
                    ForEach(content, id: \.id) { content in
                        VStack(alignment: .leading, spacing: 4) {
                            PosterView(url: content.posterURL)
                                .frame(height: Constants.posterHeight)
                            
                            Text(content.title)
                                .foregroundColor(.primary)
                                .font(.system(size: 13, weight: .medium))
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Text(content.releaseDate, formatter: DateFormatter.mediumDate)
                                .foregroundColor(.secondary)
                                .font(.system(size: 11, weight: .regular))
                        }
                        .frame(width: Constants.itemWidth)
                    }
                }
                
                Spacer(minLength: horizontalInset ?? Constants.defaultInset)
            }
        }
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
