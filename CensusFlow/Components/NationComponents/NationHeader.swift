//
//  NationHeader.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import SwiftUI

struct NationHeader: View {
    
    let year : String
    
    var body: some View {
        Text("Year: \(year), Population:")
    }
}

#Preview {
    NationHeader(year: "2024")
}
