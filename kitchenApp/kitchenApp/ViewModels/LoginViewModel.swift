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
        
    func login() {
                
        Webservice().login(id: id, password: password) { result in
            switch result {
                case .success(let token):
                    print(token)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
