//
//  ProfileScreen.swift
//  kitchenApp
//
//  Created by Olga Molenova on 14.06.22.
//
import SwiftUI
import MapKit

struct Profile {
    var name: String
    var password: String
    var userID: String
    var balance: String
}

struct ProfileScreen: View {
    
    @State var profile: Profile
    @State var mode: EditMode = .inactive
    @State var isCancelled = false
    
    @State var edit = false
    @State var showAlert = false
    
    var body: some View {
        
        Group {
            if mode.isEditing {
                editProfileView()
            } else {
                ProfileView()
            }
        }
    }
    
    
    fileprivate func ProfileView() -> some View {
        return  VStack {
            Form{
                Section(header: Text("My Info")) {
                    HStack {
                        Text("Name")
                        Spacer()
                        Text(profile.name).foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Password")
                        Spacer()
                        Text(profile.password).foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Custom ID")
                        Spacer()
                        Text(profile.userID).foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Balance")
                        Spacer()
                        Text(profile.balance).foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Purchases")
                        Spacer()
                            .foregroundColor(.secondary)
                        NavigationLink(destination: TransactionsScreen()) {}
                    }
                }
                
            }
            
            Button("Sign off?") {
                showAlert = true
            }
            .alert(isPresented: $showAlert) {
                Alert (
                    title: Text("You are signed off"),
                    message: Text("")
                )
            }
        }
        
        .navigationBarTitle(Text("Profile"))
        .navigationBarItems(trailing: EditButton())
        .navigationBarBackButtonHidden(true)
        .environment(\.editMode, self.$mode)
    }
    
    
    fileprivate func editProfileView() -> some View {
        return Form {
            
            Section(header:Text("Name")) {
                TextField("Name", text: $profile.name)
            }
            
            Section(header:Text("Password")) {
                TextField("Password", text: $profile.password)
            }
            Section(header:Text("User ID")) {
                TextField("User ID", text: $profile.userID)
                    .disabled(edit == false)
                    .foregroundColor(.secondary)
            }
            Section(header:Text("Balance")) {
                TextField("Balance", text: $profile.balance)
                    .disabled(edit == false)
                    .foregroundColor(.secondary)
            }
        }
        
        //"Cancel" still is not working very well
        .navigationBarTitle(Text("Edit Profile"))
        .navigationBarItems(leading: Button(action: {}) {NavigationLink(destination: ProfileView()) {Text("Cancel")}}, trailing: EditButton())
        .environment(\.editMode, self.$mode)
    }
    
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen(profile: Profile(name: "Peter", password: "peterchen13", userID: "12345", balance: "20$"))
    }
}
