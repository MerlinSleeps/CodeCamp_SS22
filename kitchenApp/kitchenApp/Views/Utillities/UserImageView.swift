//
//  UserImageView.swift
//  kitchenApp
//
//  Created by Willi Pindjukov on 20.07.22.
//

import SwiftUI

struct UserImageView: View {
    @ObservedObject var profile = ProfileViewModel()
    
    var body: some View {
        return Image("Image")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 70, height: 70)
            .clipped()
            .cornerRadius(150)
    }
}

struct UserImageView_Previews: PreviewProvider {
    static var previews: some View {
        UserImageView()
    }
}
