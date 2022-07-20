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
            VStack (alignment: .leading) {
                Text(item.name)
                Text("$" + String(format:"%.2f",item.price))
            }
            Spacer()
            Button("Edit") {
                
            }
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        EditItemRow(item: items1[0])
    }
}
