//
//  CreateAdminAccoutScreen.swift
//  kitchenApp
//
//  Created by Yiyu Shi on 22.07.22.
//

import SwiftUI

struct CreateAdminAccoutScreen: View {
    @State var showingCreate = false
    @State var showingDelete = false
    @State private var admin = false
    @State var idInput = ""
    @State var nameInput = ""
    @State var passwordInput = ""
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            Text("Create new Account")
                .frame(width: 300, height: 50, alignment: .leading)
                .font(.system(size: 30))
            
            TextField("id", text: $idInput)
                .font(.system(size: 30))
                .frame(width: 250, height: 40, alignment: .center)
                .border(.gray, width: 2)
            
            TextField("name", text: $nameInput)
                .font(.system(size: 30))
                .frame(width: 250, height: 40, alignment: .center)
                .border(.gray, width: 2)
            
            TextField("password", text: $passwordInput)
                .font(.system(size: 30))
                .frame(width: 250, height: 40, alignment: .center)
                .border(.gray, width: 2)
            
            
                Toggle("Is Admin?", isOn: $admin)
                    .frame(width: 160, height: 50, alignment: .leading)
            Spacer()
            Button(action: {self.showingCreate = true}, label: {
                Text("Done")
            })
            .alert(isPresented: $showingCreate) {
                Alert(title: Text("Edit Item"), message: Text("Are you sure you want create this Account?"), primaryButton: .default(Text("OK")) {
                    Webservice().createAccountAdmin(id: idInput, name: nameInput, isAdmin: admin, password: passwordInput)
                }, secondaryButton: .destructive(Text("Cancel")))
            }
            .font(.system(size: 30))
            .buttonStyle(GeneralButton())
        }
    }
}

struct CreateAdminAccoutScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateAdminAccoutScreen()
    }
}

