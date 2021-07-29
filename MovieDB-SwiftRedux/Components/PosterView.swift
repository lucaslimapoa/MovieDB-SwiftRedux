//
//  PosterView.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 29.07.21.
//

import SwiftUI
import Kingfisher

struct PosterView: View {
    private enum Constants {
        static let cornerRadius: CGFloat = 4
        static let duration = 0.35
    }
    
    let url: URL?
    
    var body: some View {
        if let url = url {
            KFImage.url(url)
                .placeholder { loadingImage() }
                .fade(duration: Constants.duration)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
                .cornerRadius(Constants.cornerRadius)
        } else {
            ZStack {
                Color.clear
                Image(systemName: "icloud.slash")
                    .font(.title)
            }
            .overlay(
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .stroke(Color.gray)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
    
    private func loadingImage() -> some View {
        ZStack {
            Color.clear
            ProgressView()
        }
    }
}

struct PosterView_Previews: PreviewProvider {
    static var previews: some View {
        PosterView(
            url: URL(string: "https://image.tmdb.org/t/p/w185_and_h278_bestv2/9E2y5Q7WlCVNEhP5GiVTjhEhx1o.jpg")!
        )
        .frame(width: 110, height: 145, alignment: .center)
        .padding()
        .previewLayout(PreviewLayout.sizeThatFits)
        
        PosterView(url: nil)
            .frame(width: 110, height: 145, alignment: .center)
            .padding()
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
