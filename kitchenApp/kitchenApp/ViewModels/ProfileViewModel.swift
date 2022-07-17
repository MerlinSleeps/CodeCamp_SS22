//
//  ProfileViewModel.swift
//  kitchenApp
//
//  Created by Olga Molenova on 17.07.22.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var userProfile: UserProfile
    @Published var isAuthorizated: Bool = false

    init() {
        self.userProfile = UserProfile(id: "xxxxxx  ", name: "n/a", balance: 0.0)
        getUserData()
    }
    
    
    func getUserData() {
        
        let defaults = UserDefaults.standard
    
        guard let id = defaults.string(forKey: "userID") else {
            return
        }
        
        guard let token = Webservice().getRefreshToken() else {
            return
        }
        
        Webservice().getUserData(id: id, token: token) {
            result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.isAuthorizated = true
                    self.userProfile.name = user.name;
                    self.userProfile.id = user.id;
                    self.userProfile.balance = user.balance;
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

