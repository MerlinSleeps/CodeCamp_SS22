//
//  BookingView.swift
//  kitchenApp
//
//  Created by Merlin Möller on 15.06.22.
//

import SwiftUI

struct BookingView: View {
    
    @State var showAlert = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack() {
                Text("Username:")
                    .font(.title)
                Text("40$")
                    .font(.title)
            }
            List{
                HStack() {
                    Text("Coffee")
                        .position(x: 50, y: 15)
                    Image(systemName: "circle.fill")
                }
                HStack() {
                    Text("Expresso")
                        .position(x: 50, y: 15)
                    Image(systemName: "circle.fill")
                }
                HStack() {
                    Text("Water")
                        .position(x: 50, y: 15)
                    Image(systemName: "circle.fill")
                }
                HStack() {
                    Text("Tea")
                        .position(x: 50, y: 15)
                    Image(systemName: "circle.fill")
                }
            }
            .navigationTitle("Bookable Items")
            Button("Buy") {
                showAlert = true
            }
            .alert(isPresented: $showAlert) {
                Alert (
                    title: Text("You are signed off"),
                    message: Text("")
                )
            }
        }
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
