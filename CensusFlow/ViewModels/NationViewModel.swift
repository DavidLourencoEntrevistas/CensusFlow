//
//  NationViewModel.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import Foundation

class NationViewModel : ObservableObject{
    
    @Published var nations: [Nation] = []
    
    private let USADataAPI : USADataAPI<[Nation]>
    
    init(USADataAPI: USADataAPI<[Nation]>) {
        self.USADataAPI = USADataAPI
    }
    
    func fetchNations() async{
        do{
            nations = try await USADataAPI.fetchData()
        }catch{
            print("Error fetching nations.")
        }
    }
    
    
}
