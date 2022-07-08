//
//  BookingView.swift
//  kitchenApp
//
//  Created by Merlin Möller on 15.06.22.
//

import SwiftUI

struct BookingView: View {
    
    @State var items = [Item]()
    
    var orderModel = OrderViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Spacer()
                    Text("")
                        .onAppear {
                        //TODO get Data for Username and Budget
                        }
                    Spacer()
                }
                
                Spacer()
                                         
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
                
                NavigationLink(destination: OrderScreenView(), label: { Text("Continue")
                            
                })
                Spacer()
            }
            .navigationTitle("Choose your Items")
        }
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
