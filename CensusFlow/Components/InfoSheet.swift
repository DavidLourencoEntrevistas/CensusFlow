//
//  InfoSheet.swift
//  CensusFlow
//
//  Created by David Lourenço on 12/10/2024.
//

import SwiftUI

struct InfoSheet: View {
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 20) {
                List{
                    Section(content: {
                        Text(GeneralConstants.description)
                            .font(.body)
                            .foregroundColor(.black)
                    }, header: {
                        Text(GeneralConstants.descriptionTitle)                            .font(.headline)
                    })
                    Section(content: {
                        Text(GeneralConstants.featuresOne)
                            .foregroundColor(.black)
                        Text(GeneralConstants.featuresTwo)
                            .foregroundColor(.black)
                        Text(GeneralConstants.featuresThree)
                            .foregroundColor(.black)
                        
                    }, header: {
                        Text(GeneralConstants.featuresTitle)
                            .font(.headline)

                    })
                    Section(content: {
                        
                        Text(GeneralConstants.howToUseOne)
                            .foregroundColor(.black)
                        
                        Text(GeneralConstants.howToUseTwo)
                            .foregroundColor(.black)
                    }, header: {
                        Text(GeneralConstants.howToUseTitle)
                            .font(.headline)
                    })
                    
                }
            }.navigationTitle(GeneralConstants.title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    
}

#Preview {
    InfoSheet()
}
