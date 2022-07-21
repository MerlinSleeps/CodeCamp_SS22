//
//  ShowAllUserScreen.swift
//  kitchenApp
//
//  Created by Merlin Möller on 18.07.22.
//

import SwiftUI

enum ShowAllUserDestination {
    case chargeMoney
    case sendMoney
    case justShow
}

struct ShowAllUserScreen: View {
    
    @State var users = [User]()
    
    var destination: ShowAllUserDestination = .justShow
    
    var body: some View {
        
        Text("12")
        /*Group {
            switch destination {
            case .chargeMoney:
                showAllUsersToChargeView()
            case .sendMoney:
                showAllUsersToSendMoneyView()
            case .justShow:
                showAllUsersToShowView()
            }
        }
        .navigationTitle("Choose a user")
        .toolbar() {
        }
        .onAppear() {
            Webservice().getAllUser { (users) in
                self.users = users
            }
        }
         */
    }
    
    fileprivate func showAllUsersToChargeView() -> some View {
        return VStack {
            List (self.users) { (user) in
                NavigationLink(destination: ChargeMoneyScreen(alertMessage: "", user: user),label: {Text(user.name)
                })
            }
        }
    }
    
    fileprivate func showAllUsersToSendMoneyView() -> some View {
        return VStack {
            List (self.users) { (user) in
                NavigationLink(destination: SendMoneyView(alertMessage: "", user: user),label: {Text(user.name)
                })
            }
        }
    }
    
    /*fileprivate func showAllUsersToShowView() -> some View {
        return VStack {
            List (self.users) { (user) in
                HStack{UserImageView()
                   Text(user.name)}
            }
        }
    }
     */
}

struct ShowAllUserScreen_Previews: PreviewProvider {
    static var previews: some View {
        ShowAllUserScreen()
    }
}
