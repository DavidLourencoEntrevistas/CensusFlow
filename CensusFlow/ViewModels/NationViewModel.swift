//
//  NationViewModel.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import Foundation

class NationViewModel : ObservableObject{
    
    @Published var nationList: [Nation] = []
    
    private let USADataAPI : USADataAPI<NationData>
    
    init(USADataAPI: USADataAPI<NationData>) {
        self.USADataAPI = USADataAPI
    }
    
    func fetchNation() async{
        do{
            let nationData = try await USADataAPI.fetchData()
            nationList = nationData.data
        }catch{
            print("Error fetching nations: \(error)")
        }
    }
    
    
}
