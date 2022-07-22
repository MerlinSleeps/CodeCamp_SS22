//
//  EditItemView.swift
//  CofeeShop
//
//  Created by Yiyu Shi on 13.06.22.
//

import SwiftUI

struct EditItemView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var item: Item
    @State var showingEdit = false
    @State var showingDelete = false
    @State var editedItemName = ""
    @State var editedItemPrice: Double = 0
    @State var alertMessage: String = ""
    var body: some View {
        VStack(spacing: 15) {
            Text("Edit Item")
                .frame(width: 300, height: 50, alignment: .leading)
                .font(.system(size: 50))
            
            TextField(item.name, text: $editedItemName)
                .font(.system(size: 30))
                .frame(width: 250, height: 40, alignment: .center)
                .border(.gray, width: 2)
            
            
            TextField(String(item.price), value: $editedItemPrice, format: .number)
                .font(.system(size: 30))
                .frame(width: 250, height: 40, alignment: .center)
                .border(.gray, width: 2)
            
            Button("Done") {
                self.showingEdit = true
                let priceString: String = String(format: "%0.02f", editedItemPrice)
                alertMessage = "Add " + editedItemName + " " + priceString + "?"
            }
                .alert(isPresented: $showingEdit) {
                    Alert(title: Text("Edit Item"),
                        message: Text(alertMessage),
                        primaryButton: .default(Text("OK")) {
                        updateItem(id: item.id, name: editedItemName, amount: item.amount, price: editedItemPrice)
                        self.presentationMode.wrappedValue.dismiss()
                        },
                        secondaryButton: .destructive(Text("Cancel")))
                }
            .buttonStyle(GeneralButton())
            
            Button(action: {self.showingDelete = true}, label: {
                Text("Delete")
                    .foregroundColor(.black)
            })
            .alert(isPresented: $showingDelete) {
                Alert(title: Text("Delete Item"), message: Text("Delete Item"), primaryButton: .default(Text("OK")) {
                    deleteItem(id: item.id)
                    self.presentationMode.wrappedValue.dismiss()
                }, secondaryButton: .destructive(Text("Cancel")))
            }
            .buttonStyle(GeneralButton())
        }
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(item: items1[0])
    }
}
