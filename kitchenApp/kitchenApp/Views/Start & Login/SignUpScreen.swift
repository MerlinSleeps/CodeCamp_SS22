//
//  SignUpScreen.swift
//  kitchenApp
//
//  Created by Olga Molenova on 18.07.22.
//

import SwiftUI

let kightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct SignUpScreen : View {
    
    @StateObject private var signUpVM = SignUpViewModel()
    @State var showAlert = false
    @State var showHint = false
    
    //password RegEx
    let password = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$")
    let securityHint = "Your password needs to have at least one digit, 8 signs, one lower case and one upper case letter"
    
    var body: some View {
        
        VStack {
            CoffeeImageView()
            if (showHint) {
                Text("\(securityHint)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
            TextField("User ID", text: $signUpVM.id)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            TextField("Name", text: $signUpVM.name)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("Password (must be at least 8 characters)", text: $signUpVM.password)
                .textInputAutocapitalization(.never)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 70)
            
            NavigationLink(destination: LoginScreen(), isActive: $signUpVM.success) {
                Button("Sign Up", action: {
                    if (password.evaluate(with: signUpVM.password)) {
                        signUpVM.signUp()
                        showAlert = true
                    } else {
                        showHint = true
                    }
                }).alert(isPresented: $showAlert) {
                        Alert (
                            title: Text("You are signed in"),
                            message: Text("")
                        )
                    }.buttonStyle(GeneralButton())
            }
        }
        .padding()
        
    }
}


struct SignUpScreen_Previews : PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
