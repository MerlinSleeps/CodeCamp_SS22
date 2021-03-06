//
//  Chart.swift
//  kitchenApp
//
//  Created by Yiyu Shi on 21.07.22.
//

import AAInfographics
import UIKit

class Chart: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize chart view control
        let chartWidth  = self.view.frame.size.width
        let chartHeight = self.view.frame.size.height-100
        let aaChartView = AAChartView()
        aaChartView.frame = CGRect(x:0, y:0, width:chartWidth, height:chartHeight)
        self.view.addSubview(aaChartView)
        
        statistic()
        var itemsName: [String] = getMostpopularItems()
        var itemsAmount: [Int] = []
        var itemsSumme: [Int] = []
        itemsName.append("others")
        for item in itemsName {
            itemsAmount.append(itemPurchaseCount[item]!)
            itemsSumme.append(Int(itemPurchaseSumme[item]!))
        }
        
        
        // Initialize chart
        let chartModel = AAChartModel()
            .chartType(.column)
            .title("Booking Statistics")
            .subtitle("")
            .inverted(false)
            .yAxisTitle("")
            .legendEnabled(true)
            .tooltipValueSuffix("")
            .categories(itemsName)
            .colorsTheme(["#fe117c","#ffc069","#06caf4"])
            .series([
                AASeriesElement()
                    .name("Amount")
                    .data(itemsAmount)
                    .toDic()!,
                AASeriesElement()
                    .name("Summe")
                    .data(itemsSumme)
                    .toDic()!
            ])
        
        aaChartView.aa_drawChartWithChartModel(chartModel)
    }
}
