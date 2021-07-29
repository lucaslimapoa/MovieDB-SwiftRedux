//
//  ContentSectionView.swift
//  ContentSectionView
//
//  Created by Lucas Lima on 29.07.21.
//

import SwiftUI

struct ContentSectionView: View {
    let header: String
    let model: LoadableModel<[Content]>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(header)
                .foregroundColor(.primary)
                .font(.headline)
                .padding(.horizontal)
            
            switch model {
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, minHeight: 135, alignment: .center)
                
            case .error:
                Text("Something went wrong")
                    .foregroundColor(.primary)
                    .font(.body)
                    .frame(maxWidth: .infinity, minHeight: 135, alignment: .center)
                
            case let .loaded(movies):
                ContentListView(content: movies)
            }
        }
        .frame(minHeight: 240, maxHeight: .infinity)
    }
}

struct ContentSectionView_Previews: PreviewProvider {
    static var previews: some View {
        ContentSectionView(header: "Header", model: .loaded(.fakeMovies))
    }
}
