//
//  Tabs.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import SwiftUI

struct Tabs: View {
    
    @StateObject var nationVM : NationViewModel = NationViewModel(USADataAPI: USADataAPI<NationData>(urlString: NationConstants.nationURL))
    
    @StateObject var statesVM : StatesViewModel = StatesViewModel(USADataAPI: USADataAPI<StateData>(urlString: StatesConstants.statesURL))
    
    var body: some View {
        TabView {
            NationList().tabItem { 
                Image(systemName: TabsConstants.nationIcon)
                Text(TabsConstants.nationText)
            }.environmentObject(nationVM)
            
            StatesList().tabItem {
                Image(systemName: TabsConstants.statesIcon)
                Text(TabsConstants.statesText)
            }.environmentObject(statesVM)
            
        }.tint(Colors.accentIconColor)
    }
}

#Preview {
    Tabs()
}
