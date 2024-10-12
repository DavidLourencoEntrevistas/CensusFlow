//
//  NationCustomList.swift
//  CensusFlow
//
//  Created by David Lourenço on 12/10/2024.
//

import SwiftUI

struct NationCustomList: View {
    
    @EnvironmentObject var nationVM : NationViewModel<USADataAPI<NationData>>
    
    var body: some View {
        List(nationVM.filteredNationList, id: \.id) { nation in
            Section(content: {
                NationRow(populationValue: nation.population)
            }, header: {
                NationHeader(year: nation.year)
            })
        }
    }
}
