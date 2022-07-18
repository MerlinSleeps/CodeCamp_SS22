//
//  LoginScreen.swift
//  kitchenApp
//
//  Created by Olga Molenova on 16.06.22.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct LoginScreen : View {
    
    @StateObject private var loginVM = LoginViewModel()
    
    var body: some View {
        
        VStack {
            WelcomeText()
            UserImage()
            TextField("User ID", text: $loginVM.id)
                .textInputAutocapitalization(.never)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("Password", text: $loginVM.password)
                .textInputAutocapitalization(.never)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 70)
            NavigationLink(destination: MainScreenAdmin(), isActive: $loginVM.isAuthenticated) {
                Button(action: {
                    loginVM.login()
                }) {
                   LoginButtonContent()
                }
            }
        }
        .padding()
    }
}


struct LoginScreen_Previews : PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}


struct WelcomeText : View {
    var body: some View {
        return Text("Welcome!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct UserImage : View {
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

struct LoginButtonContent : View {
    var body: some View {
        return Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .cornerRadius(15.0)
    }
}
