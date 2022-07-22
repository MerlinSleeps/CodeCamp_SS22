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
            }
            //Booking
            NavigationLink(destination: BookingView(), tag: 1, selection: $tag) {
                Button("Booking", action: {
                    self.tag = 1
                })
                .buttonStyle(GeneralButton())
            }
            //Profile
            NavigationLink(destination: ProfileScreen(isAdmin: false), tag: 2, selection: $tag) {
                Button("Profile", action: {
                    self.tag = 2
                })
                .buttonStyle(GeneralButton())
            }
            //Transfer Money
            NavigationLink(destination: ShowAllUserScreen(destination: .sendMoney), tag: 3, selection: $tag) {
                    Button("Send Money" ,action: {
                        self.tag = 3
                    })
                    .buttonStyle(GeneralButton())
            }.buttonStyle(GeneralButton())
            
           //Transfer History
            NavigationLink(destination: HistoryListView(), tag: 4, selection: $tag) {
                    Button("Transfer History" ,action: {
                        self.tag = 4
                    })
                    .buttonStyle(GeneralButton())
            }.buttonStyle(GeneralButton())
            
            NavigationLink(destination: ScanScreen(), tag: 5, selection: $tag) {
                    Button("Scan QR code" ,action: {
                        self.tag = 5
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

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
