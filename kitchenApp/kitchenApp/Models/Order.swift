//
//  Order.swift
//  kitchenApp
//
//  Created by Merlin Möller on 08.07.22.
//

import Foundation
import SwiftUI

struct Order: Hashable, Codable {
    var items: [Item]
}
