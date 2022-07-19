//
//  MainScreen.swift
//  kitchenApp
//
//  Created by Willi Pindjukov on 17.07.22.
//

import SwiftUI
import MapKit


struct MainScreen: View {
    @ObservedObject var profile = ProfileViewModel()
    
    @StateObject private var loginVM = LoginViewModel()
    
    @State var editProfile = Profile(name: "",password: "")
    
    var body: some View {
        VStack {
            CoffeeImageView()
            HStack {
                Text(self.profile.userProfile.name).frame(height: 30)
            }
            HStack {
                Text("Balance:")
                Text(self.profile.userProfile.balance, format: .number).frame(height: 100)
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
            }
        }
        .padding()
        .onAppear(perform: {
            profile.getUserData()
        })
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}

struct HistoryButtonContent: View {
    var body: some View {
        return Text("Transaction History")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .cornerRadius(15.0)
    }
}
