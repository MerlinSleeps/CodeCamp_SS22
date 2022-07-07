//
//  SwiftUIView.swift
//  kitchenApp
//
//  Created by Merlin Möller on 16.06.22.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Text("Username:")
                Spacer()
                Text("Budget $")
                Spacer()
            }
            
            Spacer()
            
            Text("Your order:")
            
//TODO fill list dynamicly
            List{
                HStack{
                    Text("Purchase 1")
                    Spacer()
                    Text("Amount")
                }
                HStack{
                    Text("Purchase 2")
                    Spacer()
                    Text("Amount")
                }
            }
            
            Text("Total Amount")
            
            HStack{
                Spacer()
                Button("Cancel", action: addItem)
                    .buttonStyle(.bordered)
                Spacer()
                Button("Buy", action: addItem)
                    .buttonStyle(.bordered)
                Spacer()
            }
            Spacer()
        }
    }
}

struct OrderScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
