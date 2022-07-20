//
//  Bar.swift
//  kitchenApp
//
//  Created by Yiyu Shi on 20.07.22.
//

import Foundation
import SwiftUI

struct Bar: Identifiable {
    let id: UUID = UUID()
    let value: Double
    let label: String
    let legend: Legend
}

struct Legend: Hashable {
    let color: Color
    let label: String
}
