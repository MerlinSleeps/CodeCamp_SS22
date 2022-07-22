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
    @State private var searchText = ""
    
    var destination: ShowAllUserDestination = .justShow
    
    var body: some View {
        
        Group {
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
    }
    
    fileprivate func showAllUsersToChargeView() -> some View {
        return VStack {
            List {
                ForEach(searchResults, id: \.self) { (user) in
                    NavigationLink(destination: ChargeMoneyScreen(alertMessage: "", user: user),label: {
                        HStack{UserImageView()
                           Text(user.name)}
                    })
                }
            }
            .searchable(text: $searchText)
            .textCase(.none)
        }
    }
    
    fileprivate func showAllUsersToSendMoneyView() -> some View {
        return VStack {
            List {
                ForEach(searchResults, id: \.self) { (user) in
                    NavigationLink(destination: SendMoneyView(alertMessage: "", user: user),label: {
                        HStack{UserImageView()
                           Text(user.name)}
                    })
                }
            }
            .searchable(text: $searchText)
            .textCase(.none)
        }
    }
    
    fileprivate func showAllUsersToShowView() -> some View {
        return VStack {
            List (searchResults, id: \.self) { (user) in
                HStack{UserImageView()
                   Text(user.name)}
            }
            .searchable(text: $searchText)
            .textCase(.none)
        }
    }
    
    var searchResults: [User] {
        if searchText.isEmpty {
            return users
        } else {
            return users.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct ShowAllUserScreen_Previews: PreviewProvider {
    static var previews: some View {
        ShowAllUserScreen()
    }
}
