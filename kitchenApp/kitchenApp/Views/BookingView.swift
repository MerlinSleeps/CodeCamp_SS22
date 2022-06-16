//
//  BookingView.swift
//  kitchenApp
//
//  Created by Merlin Möller on 15.06.22.
//

import SwiftUI

import SwiftUI

struct BookingView: View {
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
            
            Text("Choose your order:")
            
//TODO fill list dynamicly
            List{
                HStack{
                    Text("Purchase 1")
                    Spacer()
                    Button("Add", action: addItem)
                        .buttonStyle(.bordered)
                }
                HStack{
                    Text("Purchase 2")
                    Spacer()
                    Button("Add", action: addItem)
                        .buttonStyle(.bordered)
                }
                HStack{
                    Text("Purchase 3")
                    Spacer()
                    Button("Add", action: addItem)
                        .buttonStyle(.bordered)
                }
                HStack{
                    Text("Purchase 4")
                    Spacer()
                    Button("Add", action: addItem)
                        .buttonStyle(.bordered)
                }
            }
            
            HStack{
                Spacer()
                Button("Back", action: addItem)
                    .buttonStyle(.bordered)
                Spacer()
                Button("Continue", action: addItem)
                    .buttonStyle(.bordered)
                Spacer()
            }
            Spacer()
        }
    }
}

//TODO save data and transfer it to order screen
func addItem() {
    print("addItem")
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
