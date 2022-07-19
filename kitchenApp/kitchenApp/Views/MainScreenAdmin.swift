//
//  MainScreen.swift
//  kitchenApp
//
//  Created by Willi Pindjukov on 17.07.22.
//

import SwiftUI
import MapKit


struct MainScreenAdmin: View {
    @ObservedObject var profile = ProfileViewModel()
    
    @StateObject private var loginVM = LoginViewModel()
    
    @State var editProfile = Profile(name: "",password: "")
    
    var body: some View {
        VStack {
            CoffeeImage()
            HStack {
                Text(self.profile.userProfile.name).frame(height: 30)
            }
            HStack {
                Text("Balance:")
                Text(self.profile.userProfile.balance, format: .number)
            }
            List{
                NavigationLink(destination: BookingView()) {
                    Button(action: {
                        loginVM.login()
                    }) {
                        BookItemButtonContent()
                    }
                }
                
                NavigationLink(destination: ProfileScreen()) {
                    Button(action: {
                        loginVM.login()
                    }) {
                        EditProfileButtonContent()
                    }
                }
                
                NavigationLink(destination: HistoryListView()) {
                    Button(action: {
                        loginVM.login()
                    }) {
                        HistoryButtonContent()
                    }
                }
                
                NavigationLink(destination: EditItemListView()) {
                    Button(action: {
                        loginVM.login()
                    }) {
                        UpdateItemsButtonContent()
                    }
                }
                
                NavigationLink(destination: ShowAllUserScreen()) {
                    Button(action: {
                        loginVM.login()
                    }) {
                        ChargeMoneyButtonContent()
                    }
                }
            }
            
        }
        .padding()
        .onAppear(perform: {
            profile.getUserData()
        })
    }
}

struct MainScreenAdmin_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenAdmin()
    }
}
    
struct UpdateItemsButtonContent: View {
    var body: some View {
        return Text("Update Items")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .cornerRadius(15.0)
    }
}

struct ChargeMoneyButtonContent: View {
var body: some View {
    return Text("Recharge Money")
        .font(.headline)
        .foregroundColor(.white)
        .padding()
        .frame(width: 200, height: 50)
        .background(Color.blue)
        .cornerRadius(15.0)
    }
}

struct BookItemButtonContent: View {
    var body: some View {
        return Text("Book Items")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .cornerRadius(15.0)
    }
}
    
struct EditProfileButtonContent: View {
    var body: some View {
        return Text("Edit Profil")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .cornerRadius(15.0)
    }
}

