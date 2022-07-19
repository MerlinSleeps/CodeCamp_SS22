//
//  History.swift
//  kitchenApp
//
//  Created by Yiyu Shi on 18.07.22.
//

import Foundation
import SwiftUI

struct History: Identifiable{
    var id: Int
    var action: String = ""
    var time: String = ""
    var creditchange: Double = 0
    var itemsBought: [Item] = []
}


