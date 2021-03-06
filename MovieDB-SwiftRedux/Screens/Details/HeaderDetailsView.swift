//
//  HeaderDetailsView.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 24.08.21.
//

import SwiftUI

struct HeaderDetailsView: View {
    private enum Constants {
        static let headerHeight: CGFloat = 350
        static let backdropHeight: CGFloat = 250
        static let posterSize = CGSize(width: 100, height: 145)
    }
    
    let content: Content
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack {
                RemoteImage(url: content.backdropURL)                    
                    .frame(width: backdropWidth, height: Constants.backdropHeight, alignment: .top)
                    .clipShape(ArcRectangle())
                
                Spacer()
            }
            
            HStack(alignment: .top) {
                RemoteImage(url: content.posterURL)
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
}

struct HeaderDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderDetailsView(content: fakeMovies[0])
            .previewLayout(.sizeThatFits)
    }
}
