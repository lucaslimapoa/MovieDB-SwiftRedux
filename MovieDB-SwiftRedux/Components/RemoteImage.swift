//
//  RemoteImage.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 24.08.21.
//

import SwiftUI
import Kingfisher

struct RemoteImage: View {
    let url: URL
    
    var body: some View {
        GeometryReader { proxy in
            KFImage(url)
                .placeholder { loadingState(size: proxy.size) }
                .fade(duration: 0.35)
                .loadImmediately()
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
    
    private func loadingState(size: CGSize) -> some View {
        ProgressView()
            .frame(width: size.width, height: size.height)
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(url: URL(string: "https://image.tmdb.org/t/p/w342/be1bVF7qGX91a6c5WeRPs5pKXln.jpg")!)
            .previewLayout(.sizeThatFits)
    }
}
