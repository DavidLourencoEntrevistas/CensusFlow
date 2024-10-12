//
//  ErrorScreen.swift
//  CensusFlow
//
//  Created by David Lourenço on 12/10/2024.
//

import SwiftUI

struct ErrorScreen: View {
    var body: some View {
        VStack(alignment: .center){
            Text(GeneralConstants.errorEmoji).font(.largeTitle).multilineTextAlignment(.center)
            Text(GeneralConstants.errorScreenText).multilineTextAlignment(.center)
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ErrorScreen()
}
