//
//  SignUpViewModel.swift
//  kitchenApp
//
//  Created by Olga Molenova on 19.07.22.
//

import Foundation

class SignUpViewModel: ObservableObject {
    
    @Published var id: String = ""
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var success: Bool = false

        
    func signUp() {
               
        Webservice().signUP(id: id, name: name, password: password) { result in
            switch result {
            case .success(let id):
                DispatchQueue.main.async {
                    self.success = true
                    print(id)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

