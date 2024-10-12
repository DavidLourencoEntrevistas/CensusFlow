//
//  NationRow.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import SwiftUI

struct NationRow: View {
    
    var populationValue : Int

    var body: some View {
        HStack{
            Image(systemName: "person")
            Text("\(populationValue)")
        }
    }
}

#Preview {
    NationRow(populationValue: 0)
}
