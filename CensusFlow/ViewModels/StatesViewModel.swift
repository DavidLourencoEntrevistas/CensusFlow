//
//  StatesViewModel.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import Foundation

class StatesViewModel<T: USADataProtocol> : ObservableObject{
    @Published var states: [State] = []
    @Published var statesSearchBarText : String = ""
    @Published var showInfoView : Bool = false
    @Published var isLoading : Bool = false
    @Published var showAlert : Bool = false
    
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
    
    private let USADataAPI : T
    
    init(USADataAPI: T) {
        self.USADataAPI = USADataAPI
    }
    
    @MainActor
    func triggerAlert(){
            self.isLoading = false
            self.showAlert = true
    }
    
    @MainActor
    func triggerLoading(){
            self.isLoading = true
    }
    
    @MainActor
    func fetchState() async{
        do{
            triggerLoading()
            
            guard let stateData = try await USADataAPI.fetchData() as? StateData else{
                triggerAlert()
                return
            }
            
            self.isLoading = false
            self.states = stateData.data
            
            if states.isEmpty{
                triggerAlert()
            }
        }catch{
            triggerAlert()
        }
    }
}
