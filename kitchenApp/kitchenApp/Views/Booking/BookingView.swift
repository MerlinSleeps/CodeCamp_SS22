//
//  BookingView.swift
//  kitchenApp
//
//  Created by Merlin Möller on 15.06.22.
//

import SwiftUI

struct BookingView: View {
    
    @ObservedObject var profile = ProfileViewModel()
    
    @State var items = [Item]()
    
    var orderModel = OrderViewModel()
    
    var body: some View {
            VStack {
                List (self.items) { (item) in
                    HStack{
                        Text(item.name + ": " + String(item.price) + "€")
                        Spacer()
                        Button("Add") {
                            self.addItem(item: item)
                        }
                            .buttonStyle(.bordered)
                    }
                }
                .onAppear() {
                    Webservice().getItems { (items) in
                        self.items = items
                    }
                }
                
                NavigationLink(destination: OrderScreenView(orderModel: self.orderModel), label: { Text("Continue")
                            
                })
                .buttonStyle(GeneralButton())
                Spacer()
            }
            .navigationTitle("Choose your Items")
            .toolbar {
                Button("Refund") {
                    Webservice().refundPurchase(id: profile.userProfile.id)
                }
            }
            .onAppear() {
                self.emptyOrder()
                profile.getUserData()
            }
        }
    
    func emptyOrder() {
        orderModel.items = [Item]()
        orderModel.order.totalPrice = 0
    }
    
    func addItem(item: Item) {
        orderModel.items.append(item)
        print(orderModel.items)
    }

}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
