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
                NavigationLink(destination: ChargeMoneyScreen(userID: user.id), label: { Text(user.name)
                            
                })
            }
            .onAppear() {
                Webservice().getAllUser { (users) in
                    self.users = users
                }
            }
        }
        .navigationTitle("Choose a user")
    }

}

struct ShowAllUserScreen_Previews: PreviewProvider {
    static var previews: some View {
        ShowAllUserScreen()
    }
}
