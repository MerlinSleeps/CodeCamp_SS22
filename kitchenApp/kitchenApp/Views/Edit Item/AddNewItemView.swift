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
    @State var newItemPrice: Double = 0
    @State var alertMessage: String = ""
    
    var body: some View {
        VStack(spacing: 15) {

            Text("Add Item")
                .frame(width: 300, height: 50, alignment: .leading)
                .font(.system(size: 50))
            
            TextField("ItemName", text: $newItemName)
                .font(.system(size: 30))
                .frame(width: 250, height: 40, alignment: .center)
                .border(.gray, width: 2)
            
            TextField("Price", value: $newItemPrice, format: .number)
                .font(.system(size: 30))
                .frame(width: 250, height: 40, alignment: .center)
                .border(.gray, width: 2)
            
            Button("Done") {
                self.showingAdd = true
                let priceString: String = String(format: "%0.02f", newItemPrice)
                alertMessage = "Add " + newItemName + " " + priceString + "?"
            }
            .alert(isPresented: $showingAdd) {
                Alert(title: Text("Add Item"),
                    message: Text(alertMessage),
                    primaryButton: .default(Text("OK")) {
                        createItem(name: newItemName, price: newItemPrice)
                    },
                    secondaryButton: .destructive(Text("Cancel")))
            }
            .buttonStyle(GeneralButton())
        }
    }
}

struct AddNewItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewItem()
    }
}
