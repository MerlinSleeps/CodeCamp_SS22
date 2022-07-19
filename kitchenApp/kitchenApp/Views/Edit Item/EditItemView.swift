//
//  EditItemView.swift
//  CofeeShop
//
//  Created by Yiyu Shi on 13.06.22.
//

import SwiftUI

struct EditItemView: View {
    var item: Item
    @State var showingEdit = false
    @State var showingDelete = false
    @State var editedItemName = ""
    @State var editedItemPrice = ""
    var body: some View {
        VStack(spacing: 15) {
            Text("Edit Item")
                .frame(width: 300, height: 50, alignment: .leading)
                .font(.system(size: 50))
            
            TextField(item.name, text: $editedItemName)
                .font(.system(size: 30))
                .frame(width: 250, height: 40, alignment: .center)
                .border(.gray, width: 2)
            
            
            TextField(String(item.price), text: $editedItemPrice)
                .font(.system(size: 30))
                .frame(width: 250, height: 40, alignment: .center)
                .border(.gray, width: 2)
            
            Button(action: {self.showingEdit = true}, label: {
                Text("Done")
            })
            .alert(isPresented: $showingEdit) {
                Alert(title: Text("Edit Item"), message: Text("Change Item to " + editedItemName + " $" + editedItemPrice), primaryButton: .default(Text("OK")) {
                    let priceInDouble = Double(editedItemPrice)
                    updateItem(id: item.id, name: editedItemName, amount: item.amount, price: priceInDouble!)
                }, secondaryButton: .destructive(Text("Cancel")))
            }
            .font(.system(size: 30))
            .buttonStyle(GeneralButton())
            
            Button(action: {self.showingDelete = true}, label: {
                Text("Delete")
                    .foregroundColor(.black)
            })
            .alert(isPresented: $showingDelete) {
                Alert(title: Text("Delete Item"), message: Text("Delete Item"), primaryButton: .default(Text("OK")) {
                    deleteItem(id: item.id)
                }, secondaryButton: .destructive(Text("Cancel")))
            }
            .font(.system(size: 30))
            .buttonStyle(GeneralButton())
        }
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(item: items1[0])
    }
}
