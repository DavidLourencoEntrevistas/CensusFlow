//
//  LoadingView.swift
//  CensusFlow
//
//  Created by David Lourenço on 12/10/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView().frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    LoadingView()
}
