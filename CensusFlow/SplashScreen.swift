//
//  SplashScreen.swift
//  CensusFlow
//
//  Created by David Lourenço on 12/10/2024.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        VStack {
            Image(GeneralConstants.appIcon).resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            Text(GeneralConstants.title)
                .font(.title)
                .fontWeight(.bold)

        }.edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    SplashScreen()
}
