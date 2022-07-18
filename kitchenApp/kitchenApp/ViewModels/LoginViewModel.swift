//
//  LoginViewModel.swift
//  kitchenApp
//
//  Created by Olga Molenova on 15.06.22.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var id: String = "a3620095-0598-415f-89d6-f382a6e9d9c8"
    @Published var password: String = "iOSGroupA"
    @Published var isAuthenticated: Bool = false

        
    func login() {
        
        let defaults = UserDefaults.standard
        
        defaults.setValue(id, forKey: "userID")
        defaults.setValue(password, forKey: "userPassword")
        
        Webservice().login(id: id, password: password) { result in
            switch result {
            case .success(let token):
                defaults.setValue(token.token, forKey: "jsonwebtoken")
                defaults.setValue(token.expiration/1000, forKey: "expiration")

                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    print(token)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
    func signout() {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "jsonwebtoken")
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
}
