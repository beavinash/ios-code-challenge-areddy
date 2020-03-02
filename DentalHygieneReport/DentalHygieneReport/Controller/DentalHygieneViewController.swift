//
//  DentalHygieneViewController.swift
//  DentalHygieneReport
//
//  Created by Avinash Reddy on 3/1/20.
//  Copyright © 2020 Avinash Reddy. All rights reserved.
//

import UIKit
import Charts

class DentalHygieneViewController: UIViewController, ChartViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var labelPageNumber: UILabel!
    
    // MARK: - Properties
    var dentalData: [DentalHygiene] = []
    var dataIndex: Int = 1
    var dataUnitRepresentation = 10000
    var pageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Inititalization of LineChart and DentalHygieneAPI call from model
        lineChartView.delegate = self
        DentalHygieneAPI.requestMoreDentalHygiene(indexPageNumber: "\(dataIndex)", completionHandler: handleResponse)
    }
    
    // MARK: - IBAction methods to navigate and show different charts based on user input
    @IBAction func onSegmentUnit(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            dataUnitRepresentation = 10000
            pageIndex = 0
        } else if (sender.selectedSegmentIndex == 1) {
            dataUnitRepresentation = 7500
            pageIndex = 0
        } else {
            dataUnitRepresentation = 5000
            pageIndex = 0
        }
        handleUIUpdate()
    }
    
    @IBAction func onPreviousButtonPress(_ sender: Any) {
        if (pageIndex > 0) {
            pageIndex -= 1
            handleUIUpdate()
        }
    }
    
    @IBAction func onNextButtonPress(_ sender: Any) {
        if (Double(pageIndex) < Double(dentalData.count) / Double(dataUnitRepresentation)) {
            pageIndex += 1
            handleUIUpdate()
        }
    }
    
    // Method to compare date values to display on charts
    func compareDate(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        let year1 = calendar.component(.year, from: date1)
        let month1 = calendar.component(.month, from: date1)
        let day1 = calendar.component(.day, from: date1)
        let year2 = calendar.component(.year, from: date2)
        let month2 = calendar.component(.month, from: date2)
        let day2 = calendar.component(.day, from: date2)
        return (year1 == year2) && (month1 == month2) && (day1 == day2)
    }
    
    // MARK: - Methods to handle api response and show values on charts
    func handleResponse(value: [DentalHygiene]?, error: Error?) {
        if (value != nil) {
            dentalData.append(contentsOf: value!)
            dataIndex += 1
            DentalHygieneAPI.requestMoreDentalHygiene(indexPageNumber: "\(dataIndex)", completionHandler: handleResponse)
        } else {
            DispatchQueue.main.async {
                self.handleUIUpdate()
            }
        }
    }
    
    func handleUIUpdate() {
        
        if (dentalData.count > (pageIndex + 1) * dataUnitRepresentation) {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
        
        if (pageIndex > 0) {
            previousButton.isEnabled = true
        } else {
            previousButton.isEnabled = false
        }
        
        labelPageNumber.text = "\(pageIndex + 1)"
        
        lineChartView.noDataText = "No data for the chart"
        lineChartView.noDataTextColor = .white
        
        var dataEntries: [ChartDataEntry] = []
        var xData: [Int] = []
        var yData: [DentalHygiene] = []
        let maxCount = dentalData.count > (pageIndex + 1) * dataUnitRepresentation ? dataUnitRepresentation : dentalData.count - pageIndex * dataUnitRepresentation
        
        for index in 0..<maxCount {
            let date = Date(timeIntervalSince1970: TimeInterval(Double(dentalData[index + pageIndex * dataUnitRepresentation].timestamp)))
            
            if (yData.isEmpty || !compareDate(date1: date, date2: Date(timeIntervalSince1970: TimeInterval(Double(yData.last!.timestamp))))) {
                yData.append(dentalData[index + pageIndex * dataUnitRepresentation])
            } else {
                yData[yData.count - 1].numberOfPeople = yData[yData.count - 1].numberOfPeople + dentalData[index + pageIndex * dataUnitRepresentation].numberOfPeople
            }
        }
        
        for index in 0..<yData.count {
            let dataEntry = ChartDataEntry(x: Double(index), y: Double(yData[index].numberOfPeople))
            dataEntries.append(dataEntry)
            xData.append(yData[index].timestamp)
        }
        
        let chartDataSet = LineChartDataSet(entries: dataEntries)
        let chartData = LineChartData()
        
        formatCharYAxis(chartData, chartDataSet)
        
        formatChartXAxis(xData, chartData)
    }
    
    fileprivate func formatChartXAxis(_ xData: [Int], _ chartData: LineChartData) {
        let formatter = DayAxisValueFormatter(chart: lineChartView, xData: xData)
        let xaxis: XAxis = XAxis()
        xaxis.valueFormatter = formatter
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.extraRightOffset = 20
        lineChartView.xAxis.valueFormatter = xaxis.valueFormatter
        lineChartView.chartDescription?.enabled = false
        lineChartView.legend.enabled = true
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawLabelsEnabled = true
        lineChartView.leftAxis.spaceBottom = 0
        lineChartView.data = chartData
    }
    
    fileprivate func formatCharYAxis(_ chartData: LineChartData, _ chartDataSet: LineChartDataSet) {
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(true)
        chartDataSet.colors = [UIColor.systemPink]
        chartDataSet.setCircleColor(UIColor.systemPink)
        chartDataSet.circleHoleColor = UIColor.systemPink
        chartDataSet.circleRadius = 4.0
        chartDataSet.mode = .cubicBezier
        chartDataSet.cubicIntensity = 0.2
        chartDataSet.drawCirclesEnabled = true
        chartDataSet.drawValuesEnabled = false
    }

}
