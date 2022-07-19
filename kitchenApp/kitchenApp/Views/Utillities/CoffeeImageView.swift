//
//  CoffeeImageView.swift
//  kitchenApp
//
//  Created by Willi Pindjukov on 19.07.22.
//

import SwiftUI

struct CoffeeImageView: View {
    var body: some View {
        return Image("Image-2")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
    }
}

struct CoffeeImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeImageView()
    }
}
