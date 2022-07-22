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
    
    @State private var tag: Int? = 0
    @State var editProfile = Profile(name: "",password: "")
    
    var body: some View {
        VStack {
            CoffeeImageView()
            HStack {
                Text(self.profile.userProfile.name).frame(height: 30)
            }
            HStack {
                Text("Balance:")
                Text(self.profile.userProfile.balance, format: .number)
                    .foregroundColor(self.profile.userProfile.balance >= 0 ? .black : .red)
            }
            //Booking
            NavigationLink(destination: BookingView(), tag: 1, selection: $tag) {
                Button("Booking", action: {
                    self.tag = 1
                })
                .buttonStyle(GeneralButton())
            }
            //Profile
            NavigationLink(destination: ProfileScreen(isAdmin: true), tag: 2, selection: $tag) {
                Button("Profile", action: {
                    self.tag = 2
                })
                .buttonStyle(GeneralButton())
            }
            // Show all Users with their Images
            NavigationLink(destination: ShowAllUserScreen(destination: .justShow), tag: 3, selection: $tag) {
                Button("Show all users", action: {
                    self.tag = 3
                })
                .buttonStyle(GeneralButton())
            }
            //Transfer Money
            NavigationLink(destination: ShowAllUserScreen(destination: .sendMoney), tag: 4, selection: $tag) {
                Button("Send Money" ,action: {
                    self.tag = 4
                })
                .buttonStyle(GeneralButton())
            }
            //Charge Money
            NavigationLink(destination: ShowAllUserScreen(destination: .chargeMoney), tag: 5, selection: $tag) {
                Button("Charge Money" ,action: {
                    self.tag = 5
                })
                .buttonStyle(GeneralButton())
            }
            //Edit Item
            NavigationLink(destination: EditItemListView(), tag: 6, selection: $tag) {
                Button("Edit Item" ,action: {
                    self.tag = 6
                })
                .buttonStyle(GeneralButton())
            }
            //Create Account
            NavigationLink(destination: CreateAdminAccoutScreen(), tag: 7, selection: $tag) {
                Button("Create new Account" ,action: {
                    self.tag = 7
                })
                .buttonStyle(GeneralButton())
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
