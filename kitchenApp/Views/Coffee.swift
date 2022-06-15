//
//  Coffee.swift
//  Landmarks
//
//  Created by Willi Pindjukov on 15.06.22.
//

import SwiftUI

struct Coffee: View {
    var image: Image
    
    var body: some View {
        image.clipShape(Rectangle()).overlay {
            Rectangle().stroke(.white, lineWidth: 4)
        }.shadow(radius: 7)
    }
}

struct Coffee_Previews: PreviewProvider {
    static var previews: some View {
        Coffee(image: Image("cof"))
    }
}
