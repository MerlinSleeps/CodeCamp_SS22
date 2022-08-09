//
//  LoginScreen.swift
//  kitchenApp
//
//  Created by Olga Molenova on 16.06.22.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct LoginScreen : View {
    
    fileprivate func LoginButton() -> some View {
        Button("Login",action: {
               Task {
                   await loginVM.signIn()
               }
           })
           .buttonStyle(GeneralButton())
        
       }
    
    fileprivate func AdminLoginButton() -> some View {
            Button("Admin Login",action: {
                Task {
                    await loginVM.signInAsAdmin()
                }
            }).buttonStyle(GeneralButton())
    }
    
        
    @EnvironmentObject var loginVM: LoginViewModel
    
    var body: some View {
        
        VStack {
            WelcomeText()
            CoffeeImageView()
            Text("\(loginVM.message)")
                .foregroundColor(.red)

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
            
            Spacer()
            
            LoginButton()
            AdminLoginButton()
            
            Spacer()
            
                NavigationLink(destination: SignUpScreen()) {
                        Text("New user? Sign Up")
                }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
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
