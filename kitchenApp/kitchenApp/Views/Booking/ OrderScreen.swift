//
//  SwiftUIView.swift
//  kitchenApp
//
//  Created by Merlin Möller on 16.06.22.
//

import SwiftUI

struct OrderScreenView: View {
    
    @ObservedObject var profile = ProfileViewModel()
    
    @State var orderItems = [String]()
    @State private var showingOrderCancelAlert = false
    var orderModel = OrderViewModel()
    
    var body: some View {
            VStack {
                List (self.orderItems, id: \.self) { (item) in
                    HStack{
                        Text(item)
                    }
                }
                .onAppear() {
                    if orderItems.count > 0 {
                            return
                    }
                    let order = orderModel.calculateOrder(items: orderModel.items)
                    for (key, value) in order.counts {
                        orderItems.append("\(Double(value) * key.price)€ \(key.name)")
                    }
                }
                
                
                Text("Total Amount: " + String(orderModel.order.totalPrice))
                
                HStack{
                    Button("Buy")
                    {
                        orderModel.purchaseOrder(userId: profile.userProfile.id)
                    }
                        .buttonStyle(.bordered)
                }
                Spacer()
            }
            .navigationTitle("Confirm your Order")
            .onAppear() {
                profile.getUserData()
            }
        }
    
}

struct OrderScreenView_Previews: PreviewProvider {
    static var previews: some View {
        OrderScreenView()
    }
}
