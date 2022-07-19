//
//  HistoryItemRowView.swift
//  kitchenApp
//
//  Created by Yiyu Shi on 18.07.22.
//

import SwiftUI

struct HistoryItemRowView: View {
    var item: Item
    
    var body: some View {
        HStack {
            VStack {
                Text(item.name)
                    .frame(alignment: .leading)
                Text("$" + String(format:"%.2f", item.price))
                    .frame(alignment: .leading)
            }
            Spacer()
            Text("X" + String(item.amount))
        }
    }
}

struct HistoryItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryItemRowView(item: boughtItems[0])
    }
}
