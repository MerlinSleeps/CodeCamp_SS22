//
//  LoginViewModel.swift
//  kitchenApp
//
//  Created by Olga Molenova on 15.06.22.
//

import Foundation
import JWTDecode


enum LoginStateError: Error{
    case signInError, signOutError
}

@MainActor
class LoginViewModel: ObservableObject {

    @Published var isLoggedIn = false
    @Published var isBusy = false
    @Published var isAdmin = false
    @Published var message = ""
    @Published var id: String = ""
    @Published var password: String = ""

 //   @Published var id: String = "a3620095-0598-415f-89d6-f382a6e9d9c8"
 //   @Published var password: String = "iOSGroupA"

    var timer: Timer?

    
    func signIn() async -> Result<Bool, LoginStateError>  {
            isBusy = true
            Webservice().login(id: id, password: password) { result in
            switch result {
            case .success(let token):
                
                DispatchQueue.main.async {
                    do{
                    self.isLoggedIn = true
                    self.isAdmin = false
                        
                    AppState.shared.isLoggedIn = true
                    AppState.shared.jsonwebtoken = token.token
                    AppState.shared.expiration = token.expiration
                    AppState.shared.id = self.id
                    AppState.shared.password = self.password
                    self.message = ""
                        
                        let jwt = try decode(jwt: token.token)
                        let claim = jwt.claim(name: "isAdmin")
                        let isAdmin = claim.boolean!
                        AppState.shared.isAdminButLoggedAsUser = isAdmin;
                        
                    } catch {
                        DispatchQueue.main.async {
                            self.message = "ooops...something went wrong"
                        }
                    }
                }
             
            case .failure(let error):
                DispatchQueue.main.async {
                    self.message = error.localizedDescription
                }
            }
        }
       
        isBusy = false
        
        if(AppState.shared.isLoggedIn){
            currentUserId = id
            return .success(true)
        }
        return .failure(.signInError)
    }
    
    
    func signInAsAdmin() async -> Result<Bool, LoginStateError>  {
        
        Webservice().login(id: self.id, password: self.password) { result in
            switch result {
            case .success(let token):
               
                DispatchQueue.main.async {
                    do  {
                      let jwt  = try decode(jwt: token.token)
                        let claim = jwt.claim(name: "isAdmin")
                        let isAdmin = claim.boolean!
                        DispatchQueue.main.async {
                            if(isAdmin){
                                self.isAdmin = isAdmin;
                                self.isLoggedIn = false
                                AppState.shared.isAdmin = true
                                AppState.shared.jsonwebtoken = token.token;
                                AppState.shared.expiration = token.expiration
                                AppState.shared.id = self.id
                                AppState.shared.password = self.password
                                self.message = ""
                            } else {
                                self.message = "You are not the administrator"
                            }
                        }
                        
                    } catch {
                        DispatchQueue.main.async {
                            self.message = "oops..something went wrong"
                        }
                    }
                }
                currentUserId = self.id
            case .failure(let error):
                DispatchQueue.main.async {
                    self.message = error.localizedDescription
                }
            }
        }
        
        if(AppState.shared.isAdmin){
            return .success(true)
        }
        return .failure(.signInError)
    }

    func signOut() async -> Result<Bool, LoginStateError>  {
            isBusy = true
            logoutUser()
            isBusy = false
            return .success(true)
        }
    
    
    func logoutUser(){
        let cid = AppState.shared.id;
        isLoggedIn = false
        isBusy = false
        isAdmin = false;
        AppState.shared.jsonwebtoken = ""
        AppState.shared.expiration = -1
        AppState.shared.isAdmin = false;
        AppState.shared.isLoggedIn = false;
        AppState.shared.id = ""
        AppState.shared.password = ""
        resetTimer()
        print ("\(cid) logged out")
    }
    
    @objc func invalidateSession() {
       logoutUser()
    }
    
    
     func resetTimer() {
         timer?.invalidate()
    }
    
    func startTimer(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 60 * 5 , target: self, selector: #selector(invalidateSession), userInfo: nil, repeats: false)
    }
}
