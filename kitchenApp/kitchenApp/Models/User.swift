//
//  User.swift
//  kitchenApp
//
//  Created by Olga Molenova on 15.06.22.
//

import Foundation

struct User: Hashable, Codable, Identifiable {
    let id: String
    let name: String
}
