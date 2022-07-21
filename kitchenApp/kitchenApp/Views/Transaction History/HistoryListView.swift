//
//  HistoryListView.swift
//  kitchenApp
//
//  Created by Yiyu Shi on 18.07.22.
//

import SwiftUI

struct HistoryListView: View {
    @State var his1: [History] = []
    
    @ObservedObject var profile = ProfileViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                List(self.his1) { history in
                    if (history.type == "purchase") {
                        HistoryRow(history: history)
                    } else {
                        HistoryRow(history: history)
                    }
                }
                .onAppear(){
                    Webservice().getTransactions(id: currentUserId) { (historiesData) in
                        for h in historiesData {
                            var history = h
                            history.id = histories.count
                            histories.append(history)
                        }
                        self.his1 = histories.reversed()
                    }
                }
                .toolbar {
                    Button("Refund last item") {
                        Webservice().refundPurchase(id: profile.userProfile.id)
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
