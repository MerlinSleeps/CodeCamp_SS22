//
//  HistoryListView.swift
//  kitchenApp
//
//  Created by Yiyu Shi on 18.07.22.
//

import SwiftUI

struct HistoryListView: View {
    
    var body: some View {
        NavigationView{
            VStack {
                List(initHistory()) { history in
                    NavigationLink {
                        HistoryView(history: history)
                    } label: {
                        HistoryRow(history: history)
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
