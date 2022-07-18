//
//  User.swift
//  kitchenApp
//
//  Created by Olga Molenova on 15.06.22.
//

import Foundation

struct User: Decodable {
    let name: String
    let id: String
    let password: String
}
