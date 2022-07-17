//
//  UserProfile.swift
//  kitchenApp
//
//  Created by Olga Molenova on 17.07.22.
//

import Foundation

struct UserProfile: Decodable, Equatable {
    
    var id: String
    var name: String
    var balance: Double
}
