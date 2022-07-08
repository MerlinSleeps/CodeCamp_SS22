//
//  LoginViewModel.swift
//  kitchenApp
//
//  Created by Olga Molenova on 15.06.22.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var id: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false

        
    func login() {
        
        let defaults = UserDefaults.standard
        
        defaults.setValue(id, forKey: "userID")
        defaults.setValue(password, forKey: "userPassword")
        
        Webservice().login(id: id, password: password) { result in
            switch result {
                case .success(let token):
                defaults.setValue(token, forKey: "jsonwebtoken")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    print(token)
                }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
