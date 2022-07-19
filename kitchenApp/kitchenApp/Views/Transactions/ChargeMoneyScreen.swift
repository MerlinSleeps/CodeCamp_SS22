//
//  ChargeMoneyScreen.swift
//  kitchenApp
//
//  Created by Merlin Möller on 18.07.22.
//

import SwiftUI

struct ChargeMoneyScreen: View {
    
    @ObservedObject var profile = ProfileViewModel()
    
    @State var rechargeAmount = 0.0
    
    @State var showAlert = false
    
    var user:User
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Current Balance")) {
                    Text(user.name)
                }
                Section(header:Text("Recharge Amount")) {
                    TextField("Recharge Amount",
                              value: $rechargeAmount,
                              format: .number)
                }
            }
            Button("Fund " + user.name) {
                showAlert = true
                Webservice().fundUser(id: user.id, amount: rechargeAmount)
            }
            .buttonStyle(GeneralButton())
        }
        .navigationTitle("Fund user")
    }
}
