//
//  CoffeList.swift
//  CofeeShop
//
//  Created by Yiyu Shi on 13.06.22.
//

import Foundation
import SwiftUI

struct Item: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var amount: Int
    var price: Double
}

