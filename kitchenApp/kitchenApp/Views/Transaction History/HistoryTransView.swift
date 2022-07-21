//
//  HistoryTransView.swift
//  kitchenApp
//
//  Created by Yiyu Shi on 19.07.22.
//

import SwiftUI

struct HistoryTransView: View {
    var history: History
    
    var body: some View {
        VStack {
            Text("From: ")
                .frame(width: 350, height: 50, alignment: .leading)
                .font(.system(size: 40))
            Text(history.type)
                .frame(width: 300, height: 50, alignment: .leading)
                .font(.system(size: 30))
            Divider()
            Text("To: " )
                .frame(width: 350, height: 50, alignment: .leading)
                .font(.system(size: 40))
            Text(history.type)
                .frame(width: 300, height: 50, alignment: .leading)
                .font(.system(size: 30))
            Divider()
            Spacer()
            Divider()
            VStack {
                if (history.value >= 0) {
                    Text("Transfer amount: " + String(format:"%.2f", history.value))
                        .frame(width: 300, height: 30, alignment: .trailing)
                        .font(.system(size: 25))
                } else {
                    Text("Transfer amount: " + String(format:"%.2f", -(history.value)))
                        .frame(width: 300, height: 30, alignment: .trailing)
                        .font(.system(size: 25))
                }
                Divider()
                Text("Date: " + getTime(timeStamp: history.timestamp))
                    .frame(width: 300, height: 30, alignment:.trailing)
                    .font(.system(size: 18))
            }
        }
    }
}

struct HistoryTransView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryTransView(history: histories[0])
    }
}
