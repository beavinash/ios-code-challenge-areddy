//
//  DayAxisValueFormatter.swift
//  DentalHygieneReport
//
//  Created by Avinash Reddy on 3/2/20.
//  Copyright © 2020 Avinash Reddy. All rights reserved.
//

import Foundation
import Charts

public class DayAxisValueFormatter: NSObject, IAxisValueFormatter {
    
    weak var chart: BarLineChartViewBase?
    
    // To format all the API response data with month by month timestamp
    let months = ["Jan", "Feb", "Mar",
                  "Apr", "May", "Jun",
                  "Jul", "Aug", "Sep",
                  "Oct", "Nov", "Dec"]
    var xData: [Int] = []
    var xValue: [String: Int] = [:]
    
    init(chart: BarLineChartViewBase, xData: [Int]) {
        self.chart = chart
        self.xData = xData
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(Double(xData[Int(value)])))
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let week = calendar.component(.weekOfMonth, from: date)
        
        let monthName = "\(month)/"
        let yearName = "\(year)\n"
        let weekName = "Week \(week)"
        
        if (!xValue.keys.contains(monthName + yearName + weekName)) {
            xValue[monthName + yearName + weekName] = Int(value)
            return monthName + yearName + weekName
        } else {
            if (Int(value) == xValue[monthName + yearName + weekName]) {
                return monthName + yearName + weekName
            }
        }
        return ""
    }
}

