//
//  SwiftUIView.swift
//  kitchenApp
//
//  Created by Merlin Möller on 16.06.22.
//

import SwiftUI

struct OrderScreenView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var profile = ProfileViewModel()
    
    @State var orderItems = [String]()
    @State var showAlert = false
    @State var activeLink = false

    var orderModel = OrderViewModel()
    
    var body: some View {
            VStack {
                NavigationLink(destination: Text("Y"), isActive: $activeLink,
                               label: { EmptyView() })
                
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
                        orderItems.append(String(key.name) + " " + String(format:"%.2f", key.price) + "$ X\(value)")
                    }
                }
                
                
                Text("Total Amount: " + String(format:"%.2f", orderModel.order.totalPrice) + "$")
                
                HStack{
                    Button("Buy")
                    {
                        showAlert = true
                    }
                        .buttonStyle(GeneralButton())
                }
                Spacer()
            }
            .navigationTitle("Confirm your Order")
            .onAppear() {
                profile.getUserData()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Please confirm your order"),message: Text("You have to pay " + String(orderModel.order.totalPrice) + "$"), primaryButton: .default(Text("Confirm")) {
                    orderModel.purchaseOrder(userId: profile.userProfile.id)
                    self.presentationMode.wrappedValue.dismiss()
                }, secondaryButton: .destructive(Text("Cancel")))
            }
        }
    
}

struct OrderScreenView_Previews: PreviewProvider {
    static var previews: some View {
        OrderScreenView()
    }
}
