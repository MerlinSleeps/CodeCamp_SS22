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
                NavigationLink(destination: BookingView()) {
                    Button(action: {
                        loginVM.login()
                    }) {
                        GeneralButtonView(text: "Booking")
                    }
                }
                
                NavigationLink(destination: ProfileScreen()) {
                    Button(action: {
                        loginVM.login()
                    }) {
                        GeneralButtonView(text: "Profile")
                    }
                }
                
                NavigationLink(destination: EditItemListView()) {
                    Button(action: {
                        loginVM.login()
                    }) {
                        GeneralButtonView(text: "Edit Item")
                    }
                }
                
                NavigationLink(destination: ShowAllUserScreen()) {
                    Button(action: {
                        loginVM.login()
                    }) {
                        GeneralButtonView(text: "Users")
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
