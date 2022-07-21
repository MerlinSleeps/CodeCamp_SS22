//
//  testView.swift
//  kitchenApp
//
//  Created by Yiyu Shi on 21.07.22.
//

import SwiftUI

struct testView: View {
    @State private var showingChart = false
    
    var body: some View {
        VStack {
            Button("Show Chart") {
                self.showingChart = true
            }
        }
        .sheet(isPresented: $showingChart) {
            ChartView()
        }
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
