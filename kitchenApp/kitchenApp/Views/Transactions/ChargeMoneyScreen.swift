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
    
    var userID: String
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Current Balance")) {
                    HStack {
                        Text("Name")
                        Spacer()
                        Text(self.profile.userProfile.name).foregroundColor(.secondary)
                    }
                        
                    HStack {
                        Text("Balance")
                        Spacer()
                        Text(self.profile.userProfile.balance, format: .number).foregroundColor(.secondary)
                    }
                }
                
                Section(header:Text("Recharge Amount")) {
                    TextField("Recharge Amount",
                              value: $rechargeAmount,
                              format: .number)
                }
            }
            Button("Recharge Balance") {
                showAlert = true
                Webservice().fundUser(id: userID, amount: rechargeAmount)
            }
        }
        .navigationTitle("Fund user")
    }
}

struct ChargeMoneyScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChargeMoneyScreen(userID: "")
    }
}
