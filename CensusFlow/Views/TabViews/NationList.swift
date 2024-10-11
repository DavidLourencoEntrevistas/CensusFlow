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
            List(nationVM.nationList, id: \.year){ nation in
                Section(content: {
                    Text("Population: \(nation.population)")
                }, header: {
                    Text("Year \(nation.year)")
                })
            }.navigationTitle(NationConstants.navigationTitle)
                .task {
                  await nationVM.fetchNation()
                }
        }
    }
}

#Preview {
    NationList().environmentObject(NationViewModel(USADataAPI: USADataAPI<NationData>(urlString: NationConstants.nationURL)))
}
