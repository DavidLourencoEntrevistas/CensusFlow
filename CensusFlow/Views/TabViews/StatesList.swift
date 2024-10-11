//
//  StatesList.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import SwiftUI

struct StatesList: View {
    
    @EnvironmentObject var statesVM : NationViewModel
    
    var body: some View {
        NavigationStack {
            List{
                Section(content: {
                    
                }, header: {
                    
                })
            }.navigationTitle(StatesConstants.navigationTitle)
        }
    }
}

#Preview {
    StatesList()
}
