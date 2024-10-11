//
//  NationList.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import SwiftUI

struct NationList: View {
    
    @EnvironmentObject var nationVM : NationViewModel
    
    var body: some View {
        NavigationStack {
            List{
                Section(content: {
                    
                }, header: {
                    
                })
            }.navigationTitle(NationConstants.navigationTitle)
        }
    }
}

#Preview {
    NationList()
}
