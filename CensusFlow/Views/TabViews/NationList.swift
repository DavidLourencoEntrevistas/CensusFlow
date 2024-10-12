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
            if !nationVM.isLoading {
                List(nationVM.filteredNationList, id: \.id){ nation in
                    Section(content: {
                        NationRow(populationValue: nation.population)
                    }, header: {
                        NationHeader(year: nation.year)
                    })
                }.navigationTitle(NationConstants.navigationTitle)
                .searchable(text: $nationVM.nationSearchBarText)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                // Toggle the info view
                                nationVM.showInfoView.toggle()
                            }) {
                                Image(systemName: StatesConstants.statesInfoIcon)
                                .font(.headline)
                                .foregroundColor(Colors.accentIconColor)
                            }
                        }
                    }.sheet(isPresented: $nationVM.showInfoView){
                        InfoSheet()
                }
            } else {
                ProgressView()
            }
        }.task {
            await nationVM.fetchNation()
        }
    }
}

#Preview {
    NationList().environmentObject(NationViewModel(USADataAPI: USADataAPI<NationData>(urlString: NationConstants.nationURL)))
}
