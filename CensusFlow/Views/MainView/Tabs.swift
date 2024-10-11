//
//  Tabs.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import SwiftUI

struct Tabs: View {
    var body: some View {
        TabView {
            NationList().tabItem { 
                Image(systemName: TabsConstants.nationIcon)
                Text(TabsConstants.nationText)
            }
            StatesList().tabItem { 
                Image(systemName: TabsConstants.statesIcon)
                Text(TabsConstants.statesText)
            }
        }.tint(Colors.accentIconColor)
    }
}

#Preview {
    Tabs()
}
