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
            VStack(alignment: .leading) {
                Header(content: content)
                
                VStack(alignment: .leading, spacing: 16) {
                    section(title: "STORYLINE") {
                        Text(content.overview)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(.horizontal)
            }
        }
        .edgesIgnoringSafeArea(.vertical)
    }
    
    private func section<T>(title: String, @ViewBuilder content: () -> T) -> some View where T: View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundColor(Color(.systemGray))
                .font(.system(size: 14, weight: .medium))
            
            content()
        }
    }
}

private struct Header: View {
    private enum Constants {
        static let headerHeight: CGFloat = 350
        static let backdropHeight: CGFloat = 250
        static let posterSize = CGSize(width: 100, height: 145)
    }
    
    let content: Content
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack {
                KFImage(content.backdropURL)
                    .placeholder { loadingImage() }
                    .fade(duration: 0.35)
                    .loadImmediately()
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: backdropWidth, height: Constants.backdropHeight, alignment: .top)
                    .clipShape(ArcRectangle())
                
                Spacer()
            }
            
            HStack(alignment: .top) {
                KFImage(content.posterURL)
                    .placeholder { loadingImage() }
                    .fade(duration: 0.35)
                    .loadImmediately()
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: Constants.posterSize.width, height: Constants.posterSize.height, alignment: .center)
                    .cornerRadius(8)
                    .clipped()
                
                VStack(alignment: .leading) {
                    Text(content.title)
                        .font(.title)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.body)
                            
                            Text(content.rating)
                                .foregroundColor(Color(.systemGray))
                        }
                        
                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Image(systemName: "calendar")
                                .foregroundColor(.primary)
                                .font(.body)
                            
                            Text(content.releaseDate, formatter: DateFormatter.longDate)
                                .foregroundColor(.secondary)
                        }
                    }
                    .font(.system(size: 14))
                    
                }
                .padding(.top, 32)
            }
            .offset(x: 16, y: -16)
        }
        .frame(height: Constants.headerHeight, alignment: .bottom)
    }
    
    private var backdropWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    private func loadingImage() -> some View {
        ProgressView()
            .frame(height: Constants.backdropHeight)
    }
}

struct ContentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentDetailsView(content: fakeMovies.first!)
                .preferredColorScheme(.dark)
            
            ContentDetailsView(content: fakeMovies.first!)
                .preferredColorScheme(.light)
        }
    }
}
