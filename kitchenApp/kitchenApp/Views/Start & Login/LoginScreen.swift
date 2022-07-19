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
            CoffeeImagevView()
            TextField("User ID", text: $loginVM.id)
                .textInputAutocapitalization(.never)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
            SecureField("Password", text: $loginVM.password)
                .textInputAutocapitalization(.never)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
            
               NavigationLink(destination: MainScreen(), isActive: $loginVM.isAuthenticated) {
                Button("Login", action: {
                    loginVM.login()
                })
                .buttonStyle(GeneralButton())
            }
            
                NavigationLink(destination: MainScreenAdmin(), isActive: $loginVM.isAdmin) {
                    Button("Admin Login", action: {
                        loginVM.loginIsAdmin()
                    })
                    .buttonStyle(GeneralButton())
                }
            
            Spacer()
            
                NavigationLink(destination: SignUpScreen()) {
                        Text("New user? Sign Up")
                }
        }
        .padding()
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
}
