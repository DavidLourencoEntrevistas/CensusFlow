//
//  MainView.swift
//  CensusFlow
//
//  Created by David Lourenço on 12/10/2024.
//

import SwiftUI

struct MainView: View {
    @State private var isActive: Bool = true

    var body: some View {
        ZStack {
            if isActive {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isActive = false
                        }
                    }
            } else {
                Tabs()
            }
        }
    }
}

#Preview {
    MainView()
}
