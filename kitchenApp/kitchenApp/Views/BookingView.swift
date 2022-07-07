//
//  BookingView.swift
//  kitchenApp
//
//  Created by Merlin Möller on 15.06.22.
//

import SwiftUI

struct BookingView: View {
    
    @State var items = [Item]()
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Text("Username:")
                Spacer()
                Text("Budget $")
                Spacer()
            }
            
            Spacer()
            
            Text("Choose your order:")
                                     
//TODO fill list dynamicly
            List (items) { (item) in
                HStack{
                    Text(item.name + ": " + String(item.price))
                    Spacer()
                    Button("Add", action: addItem)
                        .buttonStyle(.bordered)
                }
            }
            .onAppear() {
                Webservice().getItems { (items) in
                    self.items = items
                }
            }.navigationTitle("Item List")
    
            HStack{
                Spacer()
                Button("Back", action: addItem)
                    .buttonStyle(.bordered)
                Spacer()
                Button("Continue", action: addItem)
                    .buttonStyle(.bordered)
                Spacer()
            }
            Spacer()
        }
    }
}

//TODO save data and transfer it to order screen
func addItem() {
    print("addItem")
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
