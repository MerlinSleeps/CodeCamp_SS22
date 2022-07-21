//
//  HistoryListView.swift
//  kitchenApp
//
//  Created by Yiyu Shi on 18.07.22.
//

import SwiftUI

struct HistoryListView: View {
    
    @ObservedObject var profile = ProfileViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                List(histories) { history in
                    if (history.action == "Bought") {
                        NavigationLink {
                            HistoryView(history: history)
                        } label: {
                            HistoryRow(history: history)
                        }
                    } else {
                        NavigationLink {
                            HistoryTransView(history: history)
                        } label: {
                            HistoryRow(history: history)
                        }
                    }
                }
                .onAppear(){
                    Webservice().getTransactions(id: profile.userProfile.id) { (his1) in
                        //self.his1 = his1
                        print(his1)
                    }
                }
                .navigationTitle("Transaction History")
            }
        }
    }
}

struct HistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryListView()
    }
}
