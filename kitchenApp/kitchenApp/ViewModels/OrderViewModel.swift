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
            order.counts[item] = (order.counts[item] ?? 0) + 1
        }
        
        order.totalPrice = 0
        
        for item in order.counts.keys {
            let price = Double(order.counts[item] ?? 0) * item.price
            order.totalPrice += price
        }
        
        return order
    }
    
    func purchaseOrder(userId: String) {

        for item in order.counts.keys {
            Webservice().purchaseItem(id: userId, itemId: item.id, amount: order.counts[item] ?? 0)
        }
    }
}
