//
//  HistoryView.swift
//  kitchenApp
//
//  Created by Yiyu Shi on 18.07.22.
//

import SwiftUI

struct HistoryView: View {
    var history: History
    
    var body: some View {
        VStack {
            List(history.itemsBought) { item in
                HistoryItemRowView(item: item)
            }
            .onAppear() {
                boughtItems = history.itemsBought
            }
            Text("Summe: " + String(history.creditchange))
                .frame(width: 300, height: 50, alignment: .trailing)
                .font(.system(size: 25))
            Text(history.time)
                .frame(width: 300, height: 50, alignment:.trailing)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(history: histories[0])
    }
}
