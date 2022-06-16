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
                .frame(width: 350, height: 50, alignment: .leading)
                .font(.system(size: 50))
            
            TextField(item.name, text: $editedItemName)
                .font(.system(size: 30))
                .frame(width: 300, height: 40, alignment: .center)
                .border(.gray, width: 2)
            
            
            TextField(String(item.price), text: $editedItemPrice)
                .font(.system(size: 30))
                .frame(width: 300, height: 40, alignment: .center)
                .border(.gray, width: 2)
            
            Button(action: {self.showingEdit = true}, label: {
                Text("Done")
            })
            .alert(isPresented: $showingEdit) {
                Alert(title: Text("Edit Item"), message: Text("Change Item to " + editedItemName + " " + editedItemPrice), primaryButton: .default(Text("OK")) {
                    createItem()
                }, secondaryButton: .destructive(Text("Cancel")))
            }
            .foregroundColor(.white)
            .font(.system(size: 30))
            .frame(width: 150, height: 40)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundColor(.cyan)
                        .blur(radius: 2)
                }
            )
            
            Button(action: {self.showingDelete = true}, label: {
                Text("Delete")
                    .foregroundColor(.black)
            })
            .alert(isPresented: $showingDelete) {
                Alert(title: Text("Delete Item"), message: Text("Delete Item"), primaryButton: .default(Text("OK")) {
                    deleteItem()
                }, secondaryButton: .destructive(Text("Cancel")))
            }
            .font(.system(size: 30))
            .frame(width: 150, height: 40)
            .background(
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundColor(.cyan)
                        .blur(radius: 2)
                }
            )
        }
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(item: items[0])
    }
}
