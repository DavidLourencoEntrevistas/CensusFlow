//
//  ErrorScreen.swift
//  CensusFlow
//
//  Created by David Lourenço on 12/10/2024.
//

import SwiftUI

struct ErrorScreen: View {
    var body: some View {
        VStack{
            Text(GeneralConstants.errorEmoji).font(.largeTitle).multilineTextAlignment(.center)
            Text(GeneralConstants.errorScreenText).multilineTextAlignment(.center)
        }.padding()
    }
}

#Preview {
    ErrorScreen()
}
