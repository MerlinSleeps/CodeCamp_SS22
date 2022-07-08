//
//  OrderViewModel.swift
//  kitchenApp
//
//  Created by Merlin Möller on 08.07.22.
//

import Foundation

class OrderViewModel: ObservableObject {
    
    @Published var items = [Item]()
    @Published var order = Order()
    
    func calculateOrder(items: [Item]) -> Order {
        
        order.counts = [:]
        
        for item in items {
            order.counts[item] = (order.counts[item] ?? 0.0) + 1.0
        }
        
        order.totalPrice = 0
        
        for item in order.counts.keys {
            order.counts[item]! *= item.price
            order.totalPrice += order.counts[item]!
        }
        
        return order
    }
    
}
