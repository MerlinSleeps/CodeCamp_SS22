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
            CoffeeImage()
            HStack {
                Text(self.profile.userProfile.name).frame(height: 30)
            }
            HStack {
                Text("Balance:")
                Text(self.profile.userProfile.balance, format: .number).frame(height: 100)
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

struct CoffeeImage : View {
    var body: some View {
        return Image("Image-2")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
    }
}

