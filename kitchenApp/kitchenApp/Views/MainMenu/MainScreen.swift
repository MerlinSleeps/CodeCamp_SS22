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
                Text(self.profile.userProfile.balance, format: .number).frame(height: 100)
            }
                NavigationLink(destination: BookingView(), tag: 1, selection: $tag) {
                    Button("Booking", action: {
                    loginVM.login()
                    self.tag = 1
                })
                .buttonStyle(GeneralButton())
            }
            NavigationLink(destination: ProfileScreen(), tag: 2, selection: $tag) {
                Button("Profile" ,action: {
                    loginVM.login()
                    self.tag = 2
                })
                .buttonStyle(GeneralButton())
            }
            NavigationLink(destination: ShowAllUserScreen(destination: .sendMoney), tag: 4, selection: $tag) {
                    Button("Send User Money" ,action: {
                        loginVM.login()
                        self.tag = 4
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
    
struct CoffeeImagevView: View {
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
