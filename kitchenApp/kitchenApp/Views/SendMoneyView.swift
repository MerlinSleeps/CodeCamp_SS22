//
//  SendMoneyView.swift
//  kitchenApp
//
//  Created by Merlin Möller on 19.07.22.
//

import SwiftUI

struct SendMoneyView: View {
    
    @ObservedObject var profile = ProfileViewModel()
    
    @State var transferAmount = 0.0
    @State var showAlert = false
    
    var recipientId: String
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Text("Your Balance")
                    Spacer()
                    Text(self.profile.userProfile.balance, format: .number).foregroundColor(.secondary)
                }
                Section(header:Text("How much do want to transfer?")) {
                    TextField("Recharge Amount", value: $transferAmount, format: .number)
                }
            }
            Button("Send") {
                showAlert = true
                Webservice().sendMoney(id: profile.userProfile.id, recipientId: self.recipientId, amount: transferAmount)
            }
        }
        .navigationTitle("Transfer Money to " + recipientId)
        .onAppear() {
            profile.getUserData()
        }
    }
}

struct SendMoneyView_Previews: PreviewProvider {
    static var previews: some View {
        SendMoneyView(recipientId: "")
    }
}
