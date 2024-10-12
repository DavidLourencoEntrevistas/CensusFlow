//
//  StatesList.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import SwiftUI

struct StatesList: View {
    
    @EnvironmentObject var statesVM : StatesViewModel
    
    var body: some View {
        NavigationStack {
            if !statesVM.isLoading {
                List(statesVM.filteredStateList, id: \.id){ state in
                        
                        if !statesVM.isLoading{
                            Section(content: {
                                StateRow(populationValue: state.population)
                            }, header: {
                                StateHeader(stateName: state.slugState)
                            })
                        }else{
                            ProgressView()
                        }
                    
                    }
                    .navigationTitle(StatesConstants.navigationTitle)
                    .searchable(text: $statesVM.statesSearchBarText)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                // Toggle the info view
                                statesVM.showInfoView.toggle()
                            }) {
                                Image(systemName: StatesConstants.statesInfoIcon)
                                .font(.headline)
                                .foregroundColor(Colors.accentIconColor)
                            }
                        }
                    }.sheet(isPresented: $statesVM.showInfoView){
                        InfoSheet()
                }
            } else {
                ProgressView()
            }
        }
        .task {
            await statesVM.fetchState()
        }
    }
}

#Preview {
    StatesList().environmentObject(StatesViewModel(USADataAPI: USADataAPI<StateData>(urlString: StatesConstants.statesURL)))
}
