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
    
    var user: User
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Text("Your Balance")
                    Spacer()
                    Text(self.profile.userProfile.balance, format: .number).foregroundColor(.secondary)
                }
                Section(header:Text("How much do want to transfer?")) {
                    TextField("Transferamount", value: $transferAmount, format: .number)
                }
            }
            Button("Transfer to " + user.name) {
                showAlert = true
                Webservice().sendMoney(id: profile.userProfile.id, recipientId: user.id, amount: transferAmount)
            }
            .buttonStyle(GeneralButton())
        }
        .navigationTitle("Transfer Money")
        .onAppear() {
            profile.getUserData()
        }
    }
}
