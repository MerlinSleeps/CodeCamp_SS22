//
//  ChargeMoneyScreen.swift
//  kitchenApp
//
//  Created by Merlin Möller on 18.07.22.
//

import SwiftUI

struct ChargeMoneyScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var profile = ProfileViewModel()
    
    @State var rechargeAmount = 0.0
    
    @State var showAlert = false
    @State var alertMessage: String
    
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
                let amountString = String(format: "%0.2f", rechargeAmount)
                alertMessage = "You are about to transfer: " + amountString + "$ to \(user.name)"
                showAlert = true
            }
            .buttonStyle(GeneralButton())
        }
        .navigationTitle("Fund user")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Please confirm the funding"), message: Text(alertMessage),
                primaryButton: .default(Text("Confirm")) {
                Webservice().fundUser(id: user.id, amount: rechargeAmount)
                self.presentationMode.wrappedValue.dismiss()
            }, secondaryButton: .destructive(Text("Cancel")))
        }
    }
}
