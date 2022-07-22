//
//  LoginViewModel.swift
//  kitchenApp
//
//  Created by Olga Molenova on 15.06.22.
//

import Foundation
import JWTDecode

class LoginViewModel: ObservableObject {
    
 //   @Published var id: String = "a3620095-0598-415f-89d6-f382a6e9d9c8"
  //  @Published var password: String = "iOSGroupA"
        
    @Published var id: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false    
    @Published var isAdmin: Bool = false
    @Published var message: String = ""

    
    
    func loginIsAdmin() {
        
        let defaults = UserDefaults.standard
        
        defaults.setValue(id, forKey: "userID")
        defaults.setValue(password, forKey: "userPassword")
        
        Webservice().login(id: id, password: password) { result in
            switch result {
            case .success(let token):
               
                DispatchQueue.main.async {
                    do  {
                      let jwt  = try decode(jwt: token.token)
                        let claim = jwt.claim(name: "isAdmin")
                        let isAdmin = claim.boolean!
                        
                        if(isAdmin){
                            defaults.setValue(true, forKey: "isAdmin")
                            defaults.setValue(token.token, forKey: "jsonwebtoken")
                            defaults.setValue(token.expiration/1000, forKey: "expiration")
                            self.isAdmin = true
                            self.message = ""
                        } else {
                            self.message = "You are not the administrator"
                        }
                    } catch {
                        self.message = "oops..something went wrong"
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.message = error.localizedDescription
                }
            }
        }
        currentUserId = id
    }

        
    func login() {
        
        let defaults = UserDefaults.standard
        
        defaults.setValue(id, forKey: "userID")
        defaults.setValue(password, forKey: "userPassword")
        
        Webservice().login(id: id, password: password) { result in
            switch result {
            case .success(let token):
                //defaults.setValue(false, forKey: "isAdmin")
                defaults.setValue(token.token, forKey: "jsonwebtoken")
                defaults.setValue(token.expiration/1000, forKey: "expiration")

                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    self.message = ""
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.message = error.localizedDescription
                }
            }
        }
        currentUserId = id
    }

    
    func signout() {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "jsonwebtoken")
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
}
