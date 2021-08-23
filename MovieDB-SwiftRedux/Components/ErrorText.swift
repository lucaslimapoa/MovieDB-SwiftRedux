//
//  ErrorText.swift
//  MovieDB-SwiftRedux
//
//  Created by Lucas Lima on 24.08.21.
//

import SwiftUI

struct ErrorText: View {
    let message = "Something went wrong"
    
    var body: some View {
        Text(message)
            .foregroundColor(.primary)
            .font(.body)
            .frame(maxWidth: .infinity, minHeight: 135, alignment: .center)
    }
}

struct ErrorText_Previews: PreviewProvider {
    static var previews: some View {
        ErrorText()
    }
}
