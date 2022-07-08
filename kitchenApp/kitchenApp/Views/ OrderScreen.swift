//
//  SwiftUIView.swift
//  kitchenApp
//
//  Created by Merlin Möller on 16.06.22.
//

import SwiftUI

struct OrderScreenView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Spacer()
                    Text("")
                        .onAppear {
                        //TODO get Data for Username and Budget
                        }
                    Spacer()
                }
                
                Spacer()
                
                List{

                }
                
                Text("Total Amount")
                
                HStack{
                    Spacer()
                    Button("Cancel", action: {})
                        .buttonStyle(.bordered)
                    Spacer()
                    Button("Buy", action: {})
                        .buttonStyle(.bordered)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct OrderScreenView_Previews: PreviewProvider {
    static var previews: some View {
        OrderScreenView()
    }
}
