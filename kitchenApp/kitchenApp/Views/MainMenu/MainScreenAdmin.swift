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
            CoffeeImagevView()
            HStack {
                Text(self.profile.userProfile.name).frame(height: 30)
            }
            HStack {
                Text("Balance:")
                Text(self.profile.userProfile.balance, format: .number)
            }
                //Booking
                NavigationLink(destination: BookingView(), tag: 1, selection: $tag) {
                    Button("Booking", action: {
                        loginVM.login()
                        self.tag = 1
                    })
                    .buttonStyle(GeneralButton())
                }
                //Profile
                NavigationLink(destination: ProfileScreen(), tag: 2, selection: $tag) {
                    Button("Profile", action: {
                        loginVM.login()
                        self.tag = 2
                    })
                    .buttonStyle(GeneralButton())
                }
                //Transfer Money
                NavigationLink(destination: ShowAllUserScreen(destination: .sendMoney), tag: 3, selection: $tag) {
                        Button("Fund user" ,action: {
                            loginVM.login()
                            self.tag = 3
                        })
                        .buttonStyle(GeneralButton())
                }.buttonStyle(GeneralButton())
                //Transfer History
            NavigationLink(destination: HistoryListView(), tag: 4, selection: $tag) {
                        Button("Transfer History" ,action: {
                            loginVM.login()
                            self.tag = 4
                        })
                        .buttonStyle(GeneralButton())
                }.buttonStyle(GeneralButton())
                //Edit Item
                NavigationLink(destination: EditItemListView(), tag: 5, selection: $tag) {
                    Button("Edit Item" ,action: {
                        loginVM.login()
                        self.tag = 5
                    })
                    .buttonStyle(GeneralButton())
                }
                //Charge Money
                NavigationLink(destination: ShowAllUserScreen(destination: .chargeMoney), tag: 6, selection: $tag) {
                        Button("Fund user" ,action: {
                            loginVM.login()
                            self.tag = 6
                        })
                        .buttonStyle(GeneralButton())
                }.buttonStyle(GeneralButton())
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
