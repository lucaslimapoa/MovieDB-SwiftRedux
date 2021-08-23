//
//  PersonView.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 24.08.21.
//

import SwiftUI
import Kingfisher

struct PersonView: View {
    private enum Constants {
        static let imageSize = CGSize(width: 80, height: 80)
        static let radius: CGFloat = 40
    }
    
    let name: String
    let imageUrl: URL
    
    var body: some View {
        VStack {
            KFImage(imageUrl)
                .placeholder { loadingImage() }
                .fade(duration: 0.35)
                .loadImmediately()
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: Constants.imageSize.width, height: Constants.imageSize.height, alignment: .center)
                .clipShape(Circle())
            
            Text(name)
                .font(.system(size: 14, weight: .medium))
                .lineLimit(3)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
        }
        .frame(width: 100, alignment: .center)
    }
    
    private func loadingImage() -> some View {
        ProgressView()
            .frame(width: Constants.imageSize.width, height: Constants.imageSize.height, alignment: .center)
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(name: "Idris Elba", imageUrl: URL(string: "https://image.tmdb.org/t/p/w342/be1bVF7qGX91a6c5WeRPs5pKXln.jpg")!)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
        
        PersonView(name: "Elisabeth Super Long Name", imageUrl: URL(string: "https://image.tmdb.org/t/p/w342/be1bVF7qGX91a6c5WeRPs5pKXln.jpg")!)
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
    }
}
