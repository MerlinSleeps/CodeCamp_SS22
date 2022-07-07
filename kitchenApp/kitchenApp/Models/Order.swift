//
//  Order.swift
//  kitchenApp
//
//  Created by Merlin Möller on 08.07.22.
//

import Foundation

struct Order: Hashable, Codable{
    let items: [Item]
}
