//
//  CastView.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 24.08.21.
//

import SwiftUI

struct CastView: View {
    let model: LoadableModel<[Actor]>
    
    var body: some View {
        switch model {
        case let .loaded(cast):
            castView(cast: cast)
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, minHeight: 135, alignment: .center)
        case .error:
            ErrorText()
        }
    }
    
    private func castView(cast: [Actor]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top) {
                ForEach(cast) { actor in
                    PersonView(name: actor.name, imageUrl: actor.avatarUrl)
                }
            }
        }
        .edgesIgnoringSafeArea(.horizontal)
    }
    
}

struct CastView_Previews: PreviewProvider {
    static var previews: some View {
        CastView(
            model: .loaded([
                Actor(id: "1", name: "Idris Elba", avatarUrl: URL(string: "https://image.tmdb.org/t/p/w342/be1bVF7qGX91a6c5WeRPs5pKXln.jpg")!),
                Actor(id: "1", name: "Another", avatarUrl: URL(string: "https://image.tmdb.org/t/p/w342/be1bVF7qGX91a6c5WeRPs5pKXln.jpg")!),
                Actor(id: "1", name: "Actor", avatarUrl: URL(string: "https://image.tmdb.org/t/p/w342/be1bVF7qGX91a6c5WeRPs5pKXln.jpg")!)
            ])
        )
        .previewLayout(.sizeThatFits)
        
        CastView(model: .loading(nil))
            .previewLayout(.sizeThatFits)
        
        CastView(model: .error)
            .previewLayout(.sizeThatFits)
    }
}
