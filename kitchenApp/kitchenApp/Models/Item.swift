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
    
    init(){
        self.id = "1"
        self.name = "2"
        self.amount = 3
        self.price = 4
        }
    init(id: String, name: String, amount: Int, price: Double){
        self.id = id
        self.name = name
        self.amount = amount
        self.price = price
        }
}


