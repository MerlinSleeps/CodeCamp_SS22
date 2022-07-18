//
//  ShowAllUserScreen.swift
//  kitchenApp
//
//  Created by Merlin Möller on 18.07.22.
//

import SwiftUI

struct ShowAllUserScreen: View {
    
    @State var users = [User]()
    
    var body: some View {
        VStack {
            List (self.users) { (user) in
                HStack{
                    Button(user.name) {
                        
                    }
                }
            }
            .onAppear() {
                Webservice().getAllUser { (user) in
                    self.users = users
                }
            }
        }
    }
}

struct ShowAllUserScreen_Previews: PreviewProvider {
    static var previews: some View {
        ShowAllUserScreen()
    }
}
