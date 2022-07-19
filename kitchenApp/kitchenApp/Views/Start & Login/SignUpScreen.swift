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
    
    var body: some View {
        
        VStack {
            CoffeeImagevView()
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
            SecureField("Password", text: $signUpVM.password)
                .textInputAutocapitalization(.never)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 70)
            
            NavigationLink(destination: LoginScreen(), isActive: $signUpVM.success) {
                Button(action: {
                    signUpVM.signUp()
                }) {
                   SignUpButtonContent()
                }
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

struct SignUpButtonContent : View {
    var body: some View {
        return Text("Sign Up")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .cornerRadius(15.0)
    }
}
