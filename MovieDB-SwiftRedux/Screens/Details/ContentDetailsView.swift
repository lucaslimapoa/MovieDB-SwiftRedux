//
//  ContentDetailsView.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 30.07.21.
//

import SwiftUI
import SwiftRedux
import Kingfisher

struct ContentDetailsView: View {
    @Dispatch<AnyAction> private var dispatch
    @SelectState(\AppState.selectedContentCast) private var cast
    @Environment(\.presentationMode) private var presentation
    
    let content: Content
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HeaderDetailsView(content: content)
                
                VStack(alignment: .leading, spacing: 16) {
                    section(title: "storyline") {
                        Text(content.overview)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    section(title: "cast") {
                        CastView(model: cast)
                    }
                }
                .padding(.horizontal)
            }
        }
        .edgesIgnoringSafeArea(.vertical)
        .onLoad(perform: fetchDetails)
        .onDisappear(perform: cleanState)
    }
    
    private func section<T>(title: String, @ViewBuilder content: () -> T) -> some View where T: View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title.uppercased())
                .foregroundColor(Color(.systemGray))
                .font(.system(size: 14, weight: .medium))
            
            content()
        }
    }
    

    private func fetchDetails() {
        dispatch(action: CastAction.fetch(id: content.id, contentType: content.contentType))
    }
    
    private func cleanState() {
        dispatch(action: CastAction.reset)
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
