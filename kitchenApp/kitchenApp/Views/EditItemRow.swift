//
//  ItemRow.swift
//  CofeeShop
//
//  Created by Yiyu Shi on 13.06.22.
//

import SwiftUI
import Foundation

struct EditItemRow: View {
    var item: Item

    
    var body: some View {
        HStack {
            VStack {
                Text(item.name)
                Text(String(item.price))
            }
            Spacer()
            Button("Edit") {
                
            }
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        EditItemRow(item: items[0])
    }
}
