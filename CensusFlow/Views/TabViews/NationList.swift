//
//  NationList.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import SwiftUI

struct NationList: View {
    
    @EnvironmentObject var nationVM : NationViewModel<USADataAPI<NationData>> 
    
    var body: some View {
        NavigationStack {
                    Group{
                        if nationVM.isLoading{
                            LoadingView()
                        }else if nationVM.showAlert{
                            ScrollView{
                                ErrorScreen()
                            }
                        }else{
                            NationCustomList()                            
                        }

                    }
                    .navigationTitle(NationConstants.navigationTitle)
                    .searchable(text: $nationVM.nationSearchBarText)
                    .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button(action: {
                                    // Toggle the info view
                                    nationVM.showInfoView.toggle()
                                }) {
                                    Image(systemName: StatesConstants.statesInfoIcon)
                                    .font(.headline)
                                    .foregroundColor(Colors.accentIconColor)
                                }
                            }
                        }
        }.task {
            await nationVM.fetchNation()
            
        }.refreshable {
            await nationVM.fetchNation()
        }.sheet(isPresented: $nationVM.showInfoView){
            InfoSheet(onClose: {
                nationVM.showInfoView = false
            })
        }
    }
}

#Preview {
    NationList().environmentObject(NationViewModel(USADataAPI: USADataAPI<NationData>(urlString: NationConstants.nationURL)))
}
