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
            Divider()
            Text("Summe: " + String(format:"%.2f", -history.creditchange))
                .frame(width: 300, height: 30, alignment: .trailing)
                .font(.system(size: 25))
            Divider()
            Text("Date: " + history.time)
                .frame(width: 300, height: 30, alignment:.trailing)
                .font(.system(size: 18))
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(history: histories[0])
    }
}
