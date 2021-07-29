//
//  FeaturedContentListView.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 29.07.21.
//

import SwiftUI

struct FeaturedContentListView: View {
    private enum Constants {
        static let defaultInset: CGFloat = 24
        static let itemSpacing: CGFloat = 12
        static let widthRatio: CGFloat = 1.77777
    }
    
    let model: LoadableModel<[Content]>
    
    var body: some View {
        switch model {
        case .loaded(let content):
            contentView(content: content)
            
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, minHeight: 135, alignment: .center)
            
        case .error:
            Text("Something went wrong")
                .foregroundColor(.primary)
                .font(.body)
                .frame(maxWidth: .infinity, minHeight: 135, alignment: .center)
        }
    }
    
    // GeometryReader is messing the height of the view
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    private func contentView(content: [Content]) -> some View {
        // GeometryReader was supposed to be used instead of the UIScreen
        // but was causing issues
        let posterWidth: CGFloat = screenWidth - Constants.defaultInset * 2
        let posterHeight: CGFloat = posterWidth / Constants.widthRatio
        let middleElement = content[content.count / 2].id

        return ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { scrollProxy in
                HStack(spacing: Constants.itemSpacing) {
                    ForEach(content, id: \.id) { content in
                        NavigationLink(destination: ContentDetailsView(content: content)) {
                                PosterView(url: content.backdropURL)
                                    .frame(width: posterWidth, height: posterHeight, alignment: .center)
                            }
                    }
                }
                .padding(.horizontal)
                .onAppear { scrollProxy.scrollTo(middleElement, anchor: .center) }
            }
        }
    }
}

struct FeaturedContentListView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedContentListView(model: .loaded(fakeMovies))
            .padding(.vertical)
            .previewLayout(PreviewLayout.sizeThatFits)
        
        FeaturedContentListView(model: .loading(nil))
            .padding(.vertical)
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
