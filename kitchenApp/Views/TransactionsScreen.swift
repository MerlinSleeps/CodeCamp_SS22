//
//  TransactionsScreen.swift
//  kitchenApp
//
//  Created by Olga Molenova on 14.06.22.
//

import SwiftUI

struct TransactionsScreen: View {
    var body: some View {
        
        List{
            Text("Purchase 1")
            Text("Purchase 2")
            Text("Purchase 3")
            Text("Purchase 4")
        }
        .navigationTitle("My Purchases")
    }
}

struct TransactionsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsScreen()
    }
}
