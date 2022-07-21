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
                Text(history.type)
                Spacer()
                let credit = history.value
                if (credit > 0) {
                    Text("+ $" + String(format:"%.2f", credit))
                        .foregroundColor(.green)
                } else {
                    Text("- $" + String(format:"%.2f", -credit))
                        .foregroundColor(.red)
                }
            }
            Spacer()
            Text(getTime(timeStamp: history.timestamp))
                .font(.system(size: 16))
        }
    }
}

struct HistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        HistoryRow(history: histories[0])
    }
}
