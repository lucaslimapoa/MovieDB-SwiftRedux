//
//  ContentDetailsView.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 30.07.21.
//

import SwiftUI
import Kingfisher

struct ContentDetailsView: View {
    @Environment(\.presentationMode) private var presentation
    
    let content: Content
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                KFImage(content.posterURL)
                    .placeholder { loadingImage() }
                    .fade(duration: 0.35)
                    .loadImmediately()
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, idealHeight: posterHeight, maxHeight: posterHeight)
                    .clipped()
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [.black, .clear]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                    .overlay(
                        VStack(alignment: .center, spacing: 0) {
                            Text(content.title)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 46, weight: .semibold))
                                .foregroundColor(.primary)
                            
                            Text(content.releaseDate, formatter: DateFormatter.year)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.gray)
                        },
                        alignment: .bottom
                    )
                
                Text(content.overview)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .edgesIgnoringSafeArea(.vertical)
    }
    
    private var posterHeight: CGFloat {
        UIScreen.main.bounds.height * 0.65
    }
    
    private func loadingImage() -> some View {
        ProgressView()
            .frame(height: posterHeight)
    }
}

struct ContentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailsView(content: fakeMovies.first!)
            .preferredColorScheme(.dark)
    }
}
