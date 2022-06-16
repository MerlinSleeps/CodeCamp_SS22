//
//  EditItemListView.swift
//  CofeeShop
//
//  Created by Yiyu Shi on 13.06.22.
//

import SwiftUI

struct EditItemListView: View {
    var body: some View {
        NavigationView{
            VStack {
                List(items) { item in
                    NavigationLink {
                        EditItemView(item: item)
                    } label: {
                        EditItemRow(item: item)
                    }
                }
                .navigationTitle("UpdateItem")
                NavigationLink{
                    AddNewItem()
                } label: {
                    Text("Add Item")
                        .font(.system(size: 30))
                }
                .navigationTitle("UpdateItem")
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
                Divider()
                Button("Back") {
                    
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
                
            }
        }
    }
}
struct EditItemListView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemListView()
    }
}
