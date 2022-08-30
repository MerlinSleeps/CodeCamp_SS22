//
//  AppState.swift
//  kitchenApp
//
//  Created by Olga Molenova on 09.08.22.
//

import Foundation

class AppState: ObservableObject {
    static let shared = AppState()
    private init() {}
    
    @Published var isLoggedIn = false
    @Published var isAdmin = false
    @Published var isAdminButLoggedAsUser = false
    @Published var jsonwebtoken = ""
    @Published var expiration:Int64 = -1
    @Published var id: String = ""
    @Published var password: String = ""

}
