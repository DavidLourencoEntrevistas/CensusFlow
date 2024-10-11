//
//  StatesViewModel.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import Foundation

class StatesViewModel : ObservableObject{
    @Published var states: [State] = []
    
    private let USADataAPI : USADataAPI<[State]>
    
    init(USADataAPI: USADataAPI<[State]>) {
        self.USADataAPI = USADataAPI
    }
    
    func fetchNations() async{
        do{
            states = try await USADataAPI.fetchData()
        }catch{
            print("Error fetching states.")
        }
    }
}
