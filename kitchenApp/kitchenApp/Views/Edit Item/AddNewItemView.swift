//
//  SwiftUIView.swift
//  CofeeShop
//
//  Created by Yiyu Shi on 13.06.22.
//

import SwiftUI

struct AddNewItem: View {
    @State var showingAdd = false
    @State var newItemName = ""
    @State var newItemPrice = ""
    var body: some View {
        VStack(spacing: 15) {
            Text("Add Item")
                .frame(width: 300, height: 50, alignment: .leading)
                .font(.system(size: 50))
            
            TextField("ItemName", text: $newItemName)
                .font(.system(size: 30))
                .frame(width: 250, height: 40, alignment: .center)
                .border(.gray, width: 2)
            
            TextField("Price", text: $newItemPrice)
                .font(.system(size: 30))
                .frame(width: 250, height: 40, alignment: .center)
                .border(.gray, width: 2)
            
            Button(action: {self.showingAdd = true}, label: {
                Text("Done")
            })
            .alert(isPresented: $showingAdd) {
                Alert(title: Text("Add Item"), message: Text("Add " + newItemName + " " + newItemPrice + "?"), primaryButton: .default(Text("OK")) {
                    createItem(name: newItemName, price: Double(newItemPrice)!)
                }, secondaryButton: .destructive(Text("Cancel")))
            }
            .font(.system(size: 30))
            .buttonStyle(GeneralButton())
        }
    }
}

struct AddNewItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewItem()
    }
}
