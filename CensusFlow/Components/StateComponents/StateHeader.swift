//
//  StateHeader.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import SwiftUI

struct StateHeader: View {
    
    let stateName : String
    
    var body: some View {
        Text("State: \(stateName), Population:")
    }
}

#Preview {
    StateHeader(stateName: "Alabama")
}
