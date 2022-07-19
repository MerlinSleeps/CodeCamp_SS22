//
//  EditItemListView.swift
//  CofeeShop
//
//  Created by Yiyu Shi on 13.06.22.
//

import SwiftUI

struct EditItemListView: View {
    @State var items = [Item]()
    
    
    var body: some View {
        NavigationView{
            VStack {
                List(self.items) { item in
                    NavigationLink {
                        EditItemView(item: item)
                    } label: {
                        EditItemRow(item: item)
                    }
                }
                .onAppear() {
                    Webservice().getItems { (items) in
                        self.items = items
                        for i in items {
                            items1.append(i)
                            print(i)
                        }
                        if (items1.isEmpty) {
                            items1.append(Item())
                        }
                    }
                }
                .navigationTitle("UpdateItem")
                NavigationLink{
                    AddNewItem()
                } label: {
                    Text("Add Item")
                }
                .buttonStyle(GeneralButton())
                .navigationTitle("UpdateItem")
                Divider()
            }
        }
    }
}
struct EditItemListView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemListView()
    }
}
