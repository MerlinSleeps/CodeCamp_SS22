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
    
    @ObservedObject var profile = ProfileViewModel()
    @State var editProfile = Profile(name: "",password: "")
    @State private var tag: Int? = 0
    @State private var isHidden: Bool = true
    
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
            let b: String = String(format: "%.1f", profile.userProfile.balance)
            return b
        }, set: {
            print ($0)
        })
    }
    
    
    @State var mode: EditMode = .inactive
    
    @State var isCancelled = false
    
    @State var edit = false
    @State var showAlert = false
    var password = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$")
    var securityHint = "Your password needs to have at least one digit, 8 signs, one lower case and one upper case letter"
    @State var hint = ""
    
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
        let pwd = AppState.shared.password
        return  VStack {
            Form {
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
                            .opacity(isHidden ? 0 : 1)
                        Button(action: { isHidden.toggle()
                        }, label: { Image (systemName: isHidden ? "eye.slash.fill" : "eye.fill")
                        })
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
                   
                }
               
            }
            
            NavigationLink(destination: HistoryListView(), tag: 1, selection: $tag) {
                Button("Transfer History" ,action: {
                    self.tag = 1
                })
                .buttonStyle(GeneralButton())
            }
        } .alert(isPresented:$isCancelled) {
            Alert(
                title: Text(securityHint).foregroundColor(.red),
                dismissButton: .destructive(Text("OK")) {
                    isCancelled = false
                }
            )
            }
        
        
        .navigationBarTitle(Text("Profile"))
        .navigationBarItems(trailing: CustomEditButton(inactive: {
            
            
        },active:{
            editProfile.name = profile.userProfile.name
            editProfile.password = AppState.shared.password
        }))
        .environment(\.editMode, self.$mode)
    }
    
    struct SecureTextField: View {
        
        @State var isSecureField: Bool = true
        @Binding var text: String
        
        var body: some View {
            HStack {
                if isSecureField {
                    SecureField("Password", text: $text)
                } else {
                    TextField(text, text: $text)
                }
            }.overlay(alignment: .trailing) {
                Image(systemName: isSecureField ? "eye.slash.fill": "eye.fill")
                    .onTapGesture {
                        isSecureField.toggle()
                    }
            }
        }
    }
    
    fileprivate func editProfileView() -> some View {
        @Environment(\.editMode) var editMode
        return Form {
            Section(header:Text("Name")) {
                TextField("Name", text: sName)
            }
            
            Section(header:Text("Password")) {
                SecureTextField(text: sPass)
            }
            Section(header:Text("User ID")) {
                TextField("User ID", text: sId)
                    .disabled(true)
                    .foregroundColor(.secondary)
            }
            Section(header:Text("Balance")) {
                TextField("Balance", text: sBalance )
                    .disabled(true)
                    .foregroundColor(.secondary)
            }
        }
        
        .navigationBarTitle(Text("Edit Profile"))
        .navigationBarItems(trailing: CustomEditButton(
            
            inactive: {
                let id   =   AppState.shared.id
                let name =  editProfile.name
                let password = editProfile.password
                if(self.password.evaluate(with: password)){
                    isCancelled = false;
                } else {
                    isCancelled = true;
                }
                if(!isCancelled){
                if (AppState.shared.isAdmin || AppState.shared.isAdminButLoggedAsUser) {
                    Webservice().updateAdmin(id: id, name: name, password: password) { result in
                        switch result {
                        case .success():
                            DispatchQueue.main.async {
                                profile.userProfile.name =  name
                                AppState.shared.password = password
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                } else {
                    Webservice().updateUser(id: id, name: name, password: password) { result in
                        switch result {
                        case .success():
                            DispatchQueue.main.async {
                                profile.userProfile.name =  name
                                AppState.shared.password = password
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
               }
            },
            active: {
                
            }
        ))
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
