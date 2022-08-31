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
    @EnvironmentObject var vm: LoginViewModel
    @State var goToLogin = false
    
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
            SecureTextField(text: $signUpVM.password)
                .textInputAutocapitalization(.never)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 70)
            
            NavigationLink(destination: LoginScreen().environmentObject(self.vm), isActive: $goToLogin) {
                Button("Sign Up", action: {
                    showHint = false
                    if (password.evaluate(with: signUpVM.password)) {
                        signUpVM.signUp()
                        vm.id=signUpVM.id
                        vm.password=signUpVM.password
                    } else {
                        showHint = true
                    }
                })
                .alert(isPresented: $signUpVM.success) {
                        Alert (
                            title: Text("You are signed in"),
                            message: Text(""),
                            dismissButton: .default(Text("OK"), action: {
                                DispatchQueue.main.async {
                                    goToLogin = true
                                }
                                
                            })
                            
                        )
                    }.buttonStyle(GeneralButton())
            }
        }
        .alert(isPresented: $signUpVM.signupFailed)
        {
            Alert(title: Text("Please enter different user ID. User with this ID already probably exists"),
                  dismissButton: .default(Text("OK"), action: {
                      DispatchQueue.main.async {
                          signUpVM.signupFailed = false
                      }
                  })
            )
        }
        .navigationViewStyle(.stack)
        .padding()
        
    }
}

struct SecureTextField: View {
    
    @State var isSecureField: Bool = true
    @Binding var text: String
    
    var body: some View {
        HStack {
            if isSecureField {
                SecureField("Password", text: $text)
            } else {
                TextField(text, text: $text)
            }
        }.overlay(alignment: .trailing) {
            Image(systemName: isSecureField ? "eye.slash.fill": "eye.fill")
                .onTapGesture {
                    isSecureField.toggle()
                }
        }
    }
}


struct SignUpScreen_Previews : PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
