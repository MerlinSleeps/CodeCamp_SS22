//
//  GeneralButtonView.swift
//  kitchenApp
//
//  Created by Merlin Möller on 19.07.22.
//

import SwiftUI

struct GeneralButton: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            // all of the modifiers you want to apply in your custom style e.g.:
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .cornerRadius(15.0)
    }
}
