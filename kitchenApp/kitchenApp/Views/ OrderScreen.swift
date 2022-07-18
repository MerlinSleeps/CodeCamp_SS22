//
//  SwiftUIView.swift
//  kitchenApp
//
//  Created by Merlin Möller on 16.06.22.
//

import SwiftUI

struct OrderScreenView: View {
    
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
                        orderItems.append("\(value)€ \(key.name)")
                    }
                }
                
                
                Text("Total Amount:" + String(orderModel.order.totalPrice))
                
                HStack{
                    Spacer()
                    Button("Buy", action: {})
                        .buttonStyle(.bordered)
                    Spacer()
                }
                Spacer()
            }
            .navigationTitle("Confirm your Order")
        }
    
}

struct OrderScreenView_Previews: PreviewProvider {
    static var previews: some View {
        OrderScreenView()
    }
}
