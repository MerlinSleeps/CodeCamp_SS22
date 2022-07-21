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
        
        // 初始化图表视图控件
        let chartWidth  = self.view.frame.size.width
        let chartHeight = self.view.frame.size.height-100
        let aaChartView = AAChartView()
        aaChartView.frame = CGRect(x:0, y:0, width:chartWidth, height:chartHeight)
        self.view.addSubview(aaChartView)
        
        var itemsName: [String] = []
        for i in items1 {
            itemsName.append(i.name)
        }
        if (itemsName.count == 0) {
            itemsName.append("water")
            itemsName.append("juice")
            itemsName.append("milk")
            itemsName.append("coffee")
            itemsName.append("ice tee")
        }
        // 初始化图表模型
        let chartModel = AAChartModel()
            .chartType(.column)//图表类型
            .title("Booking Statistics")//图表主标题
            .subtitle("")//图表副标题
            .inverted(false)//是否翻转图形
            .yAxisTitle("")// Y 轴标题
            .legendEnabled(true)//是否启用图表的图例(图表底部的可点击的小圆点)
            .tooltipValueSuffix("")//浮动提示框单位后缀
            .categories(itemsName)
            .colorsTheme(["#fe117c","#ffc069","#06caf4"])//主题颜色数组
            .series([
                AASeriesElement()
                    .name("Amount")
                    .data([7.0, 6.9, 9.5, 14.5, 18.2, 21.5])
                    .toDic()!,
                AASeriesElement()
                    .name("Summe")
                    .data([1, 3, 2, 1, 5, 6])
                    .toDic()!
            ])
        
        // 图表视图对象调用图表模型对象,绘制最终图形
        aaChartView.aa_drawChartWithChartModel(chartModel)
    }
}
