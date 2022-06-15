//
//  LoginScreen.swift
//  Landmarks
//
//  Created by Willi Pindjukov on 14.06.22.
//


import SwiftUI





struct LoginScreen: View {
    var body: some View {
        Coffee(image: Image("cof"))
            .offset(y: -200)
        Button(action: {
            print("PriceList")}) {
                Text("PriceList")
                    
                
            }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
