//
//  StatesViewModel.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import Foundation

class StatesViewModel : ObservableObject{
    @Published var states: [State] = []
    @Published var statesSearchBarText : String = ""
    @Published var showInfoView : Bool = false
    @Published var isLoading : Bool = false
    
    var filteredStateList : [State] {
        if statesSearchBarText.isEmpty{
            return states
        }else{
            return states.filter{ state in
                
                let populationStr = "\(state.population)"
                let statesSBText = statesSearchBarText.lowercased().replacingOccurrences(of: " ", with: "")
                
                return state.state.lowercased().contains(statesSBText) ||
                populationStr.lowercased().contains(statesSBText)
            }
        }
    }
    
    private let USADataAPI : USADataAPI<StateData>
    
    init(USADataAPI: USADataAPI<StateData>) {
        self.USADataAPI = USADataAPI
    }
    
    func fetchState() async{
        do{
            DispatchQueue.main.async {
                self.isLoading = true
            }
            
            let stateData = try await USADataAPI.fetchData()
            
            DispatchQueue.main.async{
                self.isLoading = false
                self.states = stateData.data
            }
        }catch{
            print("Error fetching states.")
        }
    }
}
