//
//  SendMoneyView.swift
//  kitchenApp
//
//  Created by Merlin Möller on 19.07.22.
//

import SwiftUI

struct SendMoneyView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var profile = ProfileViewModel()
    
    @State var transferAmount:Double = 0.0
    @State var showAlert = false
    @State var alertMessage: String
    
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
                let amountString = String(format: "%0.2f", transferAmount)
                alertMessage = "You are about to transfer: " + amountString + "$ to \(user.name)" 
                showAlert = true
                Webservice().sendMoney(id: profile.userProfile.id, recipientId: user.id, amount: transferAmount)
            }
            .buttonStyle(GeneralButton())
        }.alert(isPresented: $showAlert) {
            Alert(title: Text("Please confirm the transfer"), message: Text(alertMessage),
                primaryButton: .default(Text("Confirm")) {
                Webservice().fundUser(id: user.id, amount: transferAmount)
                self.presentationMode.wrappedValue.dismiss()
            }, secondaryButton: .destructive(Text("Cancel")))
        }
        .navigationTitle("Transfer Money")
        .onAppear() {
            profile.getUserData()
        }
    }
}
