//
//  GeneralButtonView.swift
//  kitchenApp
//
//  Created by Merlin Möller on 19.07.22.
//

import SwiftUI

struct GeneralButtonView: View {
    
    var text: String
    
    var body: some View {
        return Text(text)
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .cornerRadius(15.0)
    }
}

struct GeneralButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralButtonView(text: "default")
    }
}
