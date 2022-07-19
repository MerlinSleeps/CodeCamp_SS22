//
//  HistoryTransRaw.swift
//  kitchenApp
//
//  Created by Yiyu Shi on 19.07.22.
//

import SwiftUI

struct HistoryTransRaw: View {
    var history: History
    
    var body: some View {
        HStack {
            VStack {
                Text(history.action)
                Spacer()
                let credit = history.creditchange
                if (credit > 0) {
                    Text("+ $" + String(format:"%.2f", credit))
                        .foregroundColor(.green)
                } else {
                    Text("- $" + String(format:"%.2f", -credit))
                        .foregroundColor(.red)
                }
            }
            Spacer()
            Text(history.time)
                .font(.system(size: 16))
        }
    }
}


struct HistoryTransRaw_Previews: PreviewProvider {
    static var previews: some View {
        HistoryTransRaw(history: histories[0])
    }
}
