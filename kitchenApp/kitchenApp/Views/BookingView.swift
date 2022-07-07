//
//  BookingView.swift
//  kitchenApp
//
//  Created by Merlin Möller on 15.06.22.
//

import SwiftUI

struct BookingView: View {
    
    @State var items = [Item]()
    var order = [Item]()
    
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
            List (self.items) { (item) in
                HStack{
                    Text(item.name + ": " + String(item.price) + "€")
                    Spacer()
                    Button("Add", action: {})
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
                Button("Back", action: {})
                    .buttonStyle(.bordered)
                Spacer()
                Button("Continue", action: {})
                    .buttonStyle(.bordered)
                Spacer()
            }
            Spacer()
        }
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
