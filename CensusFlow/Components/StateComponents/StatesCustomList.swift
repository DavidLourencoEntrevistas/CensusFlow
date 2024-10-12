//
//  StatesCustomList.swift
//  CensusFlow
//
//  Created by David Lourenço on 12/10/2024.
//

import SwiftUI

struct StatesCustomList: View {
    
    @EnvironmentObject var statesVM : StatesViewModel<USADataAPI<StateData>>
    
    var body: some View {
        List(statesVM.filteredStateList, id: \.id) { state in
            Section(content: {
                StateRow(populationValue: state.population)
            }, header: {
                StateHeader(stateName: state.state)
            })
        }
    }
}

#Preview {
    StatesCustomList()
}
