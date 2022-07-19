//
//  HistoryView.swift
//  kitchenApp
//
//  Created by Yiyu Shi on 18.07.22.
//

import SwiftUI

struct HistoryRow: View {
    var history: History
    
    var body: some View {
        HStack {
            VStack {
                Text(history.action)
                Spacer()
                let credit = history.creditchange
                if (credit > 0) {
                    Text("+" + String(credit))
                        .foregroundColor(.green)
                } else {
                    Text(String(credit))
                        .foregroundColor(.red)
                }
            }
            Spacer()
            Text(history.time)
                .font(.system(size: 16))
        }
    }
}

struct HistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        HistoryRow(history: histories[0])
    }
}
