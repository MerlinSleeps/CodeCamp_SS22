//
//  TimeChart.swift
//  kitchenApp
//
//  Created by Yiyu Shi on 22.07.22.
//

import AAInfographics
import UIKit

class TimeChart: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize chart view control
        let chartWidth  = self.view.frame.size.width
        let chartHeight = self.view.frame.size.height-100
        let aaChartView = AAChartView()
        aaChartView.frame = CGRect(x:0, y:0, width:chartWidth, height:chartHeight)
        self.view.addSubview(aaChartView)
        
        analysisOfTime()
        var names: [String] = []
        /*
        // current timeStamp
        let timeInterval:TimeInterval = Date().timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        */
        // timeStamp of 2022-07-23 
        let timeStamp = 1658570400
        var s = 6
        var itemsAmount: [Int] = []
        var itemsSumme: [Int] = []
        while (s >= 1) {
            itemsAmount.append(amountInTime[String(s)] ?? 0)
            itemsSumme.append(Int(summeInTime[String(s)] ?? 0.0))
            s -= 1
            names.append(getDate(timeStamp: timeStamp-myTimeInterval*s))
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
            .categories(names)
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
