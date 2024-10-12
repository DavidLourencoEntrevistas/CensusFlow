//
//  NationViewModel.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import Foundation

class NationViewModel<T: USADataProtocol> : ObservableObject{
    
    @Published var nationList: [Nation] = []
    @Published var nationSearchBarText : String = ""
    @Published var showInfoView : Bool = false
    @Published var isLoading : Bool = false
    @Published var showAlert : Bool = false
    
    private let USADataAPI : T
    
    var filteredNationList : [Nation] {
        if nationSearchBarText.isEmpty{
            return nationList
        }else{
            return nationList.filter{ nation in
                let populationStr = "\(nation.population)"
                let nationSBText = nationSearchBarText.replacingOccurrences(of: " ", with: "")
                
                return nation.year.lowercased().contains(nationSBText) || populationStr.contains(nationSBText)
            }
        }
    }
    
    
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
    func fetchNation() async{
        do{
            triggerLoading()
            
            guard let nationData = try await USADataAPI.fetchData() as? NationData else{
                triggerAlert()
                return
            }
            
            self.isLoading = false
            self.nationList = nationData.data
            
            if nationList.isEmpty{
                triggerAlert()
            }
                    
        }catch{
            triggerAlert()
        }
    }
    
    
}
