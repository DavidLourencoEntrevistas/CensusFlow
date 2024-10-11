//
//  StatesViewModel.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import Foundation

class StatesViewModel : ObservableObject{
    @Published var states: [State] = []
    
    private let USADataAPI : USADataAPI<StateData>
    
    init(USADataAPI: USADataAPI<StateData>) {
        self.USADataAPI = USADataAPI
    }
    
    func fetchNations() async{
        do{
            let stateData = try await USADataAPI.fetchData()
            states = stateData.data
        
        }catch{
            print("Error fetching states.")
        }
    }
}
