//
//  NationViewModel.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import Foundation

class NationViewModel : ObservableObject{
    
    @Published var nationList: [Nation] = []
    @Published var nationSearchBarText : String = ""
    @Published var showInfoView : Bool = false
    @Published var isLoading : Bool = false
    
    private let USADataAPI : USADataAPI<NationData>
    
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
    
    
    init(USADataAPI: USADataAPI<NationData>) {
        self.USADataAPI = USADataAPI
    }
    
    func fetchNation() async{
        do{
            DispatchQueue.main.async {
                self.isLoading = true
            }
            
            let nationData = try await USADataAPI.fetchData()
            
            DispatchQueue.main.async{
                self.isLoading = false
                self.nationList = nationData.data
            }
        }catch{
            print("Error fetching nations: \(error)")
        }
    }
    
    
}
