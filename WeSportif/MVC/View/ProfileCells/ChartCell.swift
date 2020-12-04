

import UIKit
import SwiftChart

class ChartCell: UITableViewCell {
    @IBOutlet weak var chart: Chart!
    fileprivate var labelLeadingMarginInitialConstant: CGFloat!
    var stockValues: Array<Dictionary<String, Any>> = [["":""]]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: View Settings
    override func layoutSubviews() {
        super.layoutSubviews()
        chart.setNeedsDisplay()
        initializeChart()
        
    }
//    func initializeChart() {
//
//        // Initialize data series and labels
//        getStockValues { (values) in
//            if !values.isEmpty {
//                self.stockValues = values
//                var serieData: [Double] = []
//                var labels: [Double] = []
//                var labelsAsString: Array<String> = []
//
//                // Date formatter to retrieve the month names
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "MM"
//                for (i, value) in self.stockValues.enumerated() {
//
//                    serieData.append(value["close"] as! Double)
//                    labels.append(Double(i))
//                    labelsAsString.append(value["date"] as! String)
//                }
//                self.chart.xLabels = labels
//                let series = ChartSeries(serieData)
//                series.color = UIColor(red:0.04, green:1.00, blue:0.38, alpha:1.0)
//                series.area = true
//                self.chart.xLabelsFormatter = { (labelIndex: Int, labelValue: Double) -> String in
//                    return labelsAsString[labelIndex]
//                }
//
//                self.initChartView()
//                self.chart.minY = serieData.min()! - 5
//                // add chart to view
//                self.chart.add(series)
//            }
//
//        }
//    }
    
    func initializeChart() {
        //chart.delegate = self
        
        // Initialize data series and labels
        let stockValues = getStockValues()
        
        var serieData: [Double] = []
        var labels: [Double] = []
        var labelsAsString: Array<String> = []
        
        // Date formatter to retrieve the month names
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        
        for (i, value) in stockValues.enumerated() {
            
            serieData.append(value["close"] as! Double)
            
            // Use only one label for each month
            let month = Int(dateFormatter.string(from: value["date"] as! Date))!
            let monthAsString:String = dateFormatter.monthSymbols[month - 1]
            if (labels.count == 0 || labelsAsString.last != monthAsString) {
                labels.append(Double(i))
                labelsAsString.append(monthAsString)
            }
        }
        
        let series = ChartSeries(serieData)
        series.area = true
        
        // Configure chart layout
        
        chart.lineWidth = 0.5
        chart.labelFont = UIFont.systemFont(ofSize: 12)
        self.chart.xLabels = labels
        series.color = UIColor(red:0.91, green:0.30, blue:0.24, alpha:1.0)
        series.area = true
        self.chart.xLabelsFormatter = { (labelIndex: Int, labelValue: Double) -> String in
            return labelsAsString[labelIndex]
        }
        self.initChartView()
        self.chart.minY = serieData.min()! - 5
        
        chart.add(series)
        
    }
    
    
    
    // MARK: get the stock Value from WS
    
//    func getStockValues(completion: @escaping (Array<Dictionary<String, Any>>)-> Void)  {
//        // show loader
//
//        LoginWS.shared.refreshUser { (response) in
//            if let success = response, success {
//                LoginWS.shared.getChartForUser { (data) in
//
//                    // get chart Data
//                    let json: NSDictionary = (try! JSONSerialization.jsonObject(with: data, options: [])) as! NSDictionary
//
//                    let jsonValues = json["result"] as! NSDictionary
//                    let jsonChartData = jsonValues["dayStats"] as! Array<NSDictionary>
//                    // Parse data
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "yyyy-MM-dd"
//                    let values = jsonChartData.map { (value: NSDictionary) -> Dictionary<String, Any> in
//                        let date = value["day"]! as! String
//                        let close = (value["value"]! as! NSNumber).doubleValue
//                        return ["day": date, "value": close]
//                    }
//                    // return json as array
//                    completion( values)
//                } } else {
//                AlertPopUp().getAlertWithOkMessage(title: "Undefind", message: "Error while authentificate User", viewController: self.viewContainingController()!)
//            }
//        }
//    }
    
    func getStockValues() -> Array<Dictionary<String, Any>> {
        
        // Read the JSON file
        let filePath = Bundle.main.path(forResource: "AAPL", ofType: "json")!
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath))
        let json: NSDictionary = (try! JSONSerialization.jsonObject(with: jsonData!, options: [])) as! NSDictionary
        let jsonValues = json["quotes"] as! Array<NSDictionary>
        
        // Parse data
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let values = jsonValues.map { (value: NSDictionary) -> Dictionary<String, Any> in
            let date = dateFormatter.date(from: value["date"]! as! String)
            let close = (value["close"]! as! NSNumber).doubleValue
            return ["date": date!, "close": close]
        }
        
        return values
        
    }
    
    func initChartView() {
        
        // Configure chart layout
        self.chart.lineWidth = 0.5
        self.chart.highlightLineColor = .clear
        self.chart.axesColor = UIColor(red:0.91, green:0.30, blue:0.24, alpha:1.0)
        
        self.chart.labelFont = UIFont.systemFont(ofSize: 12)
        self.chart.areaAlphaComponent = 0.4
        self.chart.labelColor = .black
        self.chart.xLabelsTextAlignment = .center
        self.chart.axesColor = .clear
        
        self.chart.showYLabelsAndGrid = false
        // Add some padding above the x-axis
        
        self.chart.backgroundColor = .white
    }
}
