//
//  HistoryListView.swift
//  kitchenApp
//
//  Created by Yiyu Shi on 18.07.22.
//

import SwiftUI

struct HistoryListView: View {
    @State var his1: [History] = []
    @State private var isShowing = true
    @State private var showingChart = false
    @State private var showingTimeChart = false
    
    @ObservedObject var profile = ProfileViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                if (isShowing){
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
                            Webservice().getTransactions(id: currentUserId) { (historiesData) in
                                for h in historiesData {
                                    var history = h
                                    history.id = histories.count
                                    histories.append(history)
                                }
                                self.his1 = histories.reversed()
                            }
                            if (isShowing) {
                                isShowing = false
                            } else {
                                isShowing = true
                            }
                        }
                    }
                    .navigationTitle("Transaction History")
                } else {
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
                            Webservice().getTransactions(id: currentUserId) { (historiesData) in
                                for h in historiesData {
                                    var history = h
                                    history.id = histories.count
                                    histories.append(history)
                                }
                                self.his1 = histories.reversed()
                            }
                            if (isShowing) {
                                isShowing = false
                            } else {
                                isShowing = true
                            }
                        }
                    }
                    .navigationTitle("Transaction History")
                }
                Button("Statistics by Item") {
                        self.showingChart = true
                }
                .buttonStyle(GeneralButton())
                Button("Statistics by Time") {
                        self.showingTimeChart = true
                }
                .buttonStyle(GeneralButton())
            }
            .sheet(isPresented: $showingChart) {
                ChartView()
            }
            .sheet(isPresented: $showingTimeChart) {
                TimeChartView()
            }
        }
    }
}

struct HistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryListView()
    }
}
