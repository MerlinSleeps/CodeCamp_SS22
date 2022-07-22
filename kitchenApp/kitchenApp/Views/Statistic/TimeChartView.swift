//
//  TimeChartView.swift
//  kitchenApp
//
//  Created by Yiyu Shi on 22.07.22.
//

import SwiftUI
import AAInfographics

struct TimeChartView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let chart = TimeChart()
        return chart
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
