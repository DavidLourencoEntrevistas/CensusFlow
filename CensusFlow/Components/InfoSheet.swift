//
//  InfoSheet.swift
//  CensusFlow
//
//  Created by David Lourenço on 12/10/2024.
//

import SwiftUI

struct InfoSheet : View {
    
    var onClose: () -> Void
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 20) {
                List {
                    ForEach(GeneralConstants.infoSheetDict.keys.sorted(by: >), id: \.self) { title in
                        Section(header: Text(title).font(.headline)) {
                            ForEach(GeneralConstants.infoSheetDict[title]!, id: \.self) { content in
                                Text(content)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
            }.navigationTitle(GeneralConstants.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            // Toggle the info view
                            onClose()
    
                        }) {
                            Image(systemName: GeneralConstants.closeIcon)
                                .font(.callout)
                            .foregroundColor(Colors.accentIconColor)
                        }
                    }
                }
        }
    }
    
    
}

#Preview {
    InfoSheet(onClose: {})
}
