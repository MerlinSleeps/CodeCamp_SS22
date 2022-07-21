//
//  History.swift
//  kitchenApp
//
//  Created by Yiyu Shi on 18.07.22.
//

import Foundation
import SwiftUI

struct History: Identifiable, Decodable{
    var type: String
    var value: Double
    var timestamp: Int
    var itemId: String?
    var itemName: String?
    var amount: Int?
    var id: Int? 
}


