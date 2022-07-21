//
//  ChartView.swift
//  kitchenApp
//
//  Created by Yiyu Shi on 21.07.22.
//

import Foundation
import UIKit
import AAInfographics
import SwiftUI

struct ChartView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<ChartView>) -> UIViewController {
        let chart = Chart()
        return chart
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<ChartView>) {
    }
}
