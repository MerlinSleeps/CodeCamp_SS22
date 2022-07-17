//
//  ProfileScreen.swift
//  kitchenApp
//
//  Created by Olga Molenova on 14.06.22.
//
import SwiftUI
import MapKit

struct Profile : Equatable {
    var name: String
    var password: String
    
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        return lhs.name == rhs.name && lhs.password == rhs.password
        }
}



struct ProfileScreen: View {
    
    @StateObject var profile = ProfileViewModel()
    
    @State var editProfile = Profile(name: "",password: "")
   
    var sName: Binding<String> {
           .init(get: {
               return editProfile.name
           }, set: {
               editProfile.name = $0
           })
       }
    var sPass: Binding<String> {
           .init(get: {
               return editProfile.password
           }, set: {
               editProfile.password = $0
           })
       }
    
    var sId: Binding<String> {
        .init(get: {
            return profile.userProfile.id
        }, set: {
            print ($0)
        })
    }
    
    
    var sBalance: Binding<String> {
        .init(get: {
            let b: String = String(format: "%f", profile.userProfile.balance)
            return b
        }, set: {
            print ($0)
        })
    }
    

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
        @Environment(\.editMode) var editMode

        let defaults = UserDefaults.standard
        let pwd = defaults.string(forKey: "userPassword")!
        return  VStack {
            Form{
                Section(header: Text("My Info")) {
                    HStack {
                        Text("Name")
                        Spacer()
                        Text(self.profile.userProfile.name).foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Password")
                        Spacer()
                        Text(pwd).foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Custom ID")
                        Spacer()
                        Text(self.profile.userProfile.id).foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Balance")
                        Spacer()
                        Text(self.profile.userProfile.balance, format: .number).foregroundColor(.secondary)
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
        .navigationBarItems(trailing: CustomEditButton(inactive: {
     
            
        },active:{
            editProfile.name = profile.userProfile.name
            editProfile.password = UserDefaults.standard.string(forKey: "userPassword")!
        }))
 //       .navigationBarBackButtonHidden(true)
        .environment(\.editMode, self.$mode)

    }

    
    fileprivate func editProfileView() -> some View {
        @Environment(\.editMode) var editMode
        return Form {
            Section(header:Text("Name")) {
                TextField("Name", text: sName)
            }
            
            Section(header:Text("Password")) {
                TextField("Password", text: sPass)
            }
            Section(header:Text("User ID")) {
                TextField("User ID", text: sId)
                    .disabled(true)
                    .foregroundColor(.secondary)
            }
            Section(header:Text("Balance")) {
                TextField("Balance", text: sBalance)
                    .disabled(true)
                    .foregroundColor(.secondary)
            }
        }
        
        //"Cancel" still is not working very well
        .navigationBarTitle(Text("Edit Profile"))
        .navigationBarItems(trailing: CustomEditButton(
       
            inactive: {
            let id   =   UserDefaults.standard.string(forKey: "userID")!
            let name =  editProfile.name
            let password = editProfile.password
            Webservice().updateUser(id: id, name: name, password: password) { result in
                             switch result {
                             case .success():
                                 profile.userProfile.name =  name
                                 UserDefaults.standard.setValue(password, forKey: "userPassword")
                             case .failure(let error):
                                 print(error.localizedDescription)
                             }
                         }
        },
            active: {
              
            }
        ))
//        .navigationBarItems(leading: Button(action: {}) {NavigationLink(destination: ProfileView()) {Button("Cancel")}}, trailing: EditButton())
        .navigationBarBackButtonHidden(true)
        .environment(\.editMode, self.$mode)
     
}
    
    struct CustomEditButton: View {
        @Environment(\.editMode) var editMode
        
        var inactive: () -> Void
        var active: () -> Void
        private var isEditing: Bool {
            editMode?.wrappedValue.isEditing ?? false
        }
        
        var body: some View {
            Button(action: {
                withAnimation {
                    editMode?.wrappedValue = isEditing ? .inactive : .active
                }
                if(editMode?.wrappedValue == .active){
                    self.active()
                } else if(editMode?.wrappedValue == .inactive){
                    self.inactive()
                }
            }, label: {
                Image(systemName: isEditing ? "pencil.circle.fill" : "pencil.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
            })
        }
    }

}
