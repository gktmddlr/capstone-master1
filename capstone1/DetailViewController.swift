//
//  DetailViewController.swift
//  capstone1
//
//  Created by 하승익 on 08/05/2019.
//  Copyright © 2019 하승익. All rights reserved.
//

//ppt 동영상 위키링크.
//설명 부분 추가 수치의미,
//정확히 언제 오른다는건지 내린다는건지. -> 의미 해석
//이 앱이 무슨 의미가 있나 설명을 해야한다.
//주가 예측 년 단위 예측임.
//svm에 대한 설명. 굳이 이거 쓸필요가 연단위라면.
//사용하는 파라미터는 평균값인지 연별.
//feature에 대한 것들도 추가.
//어떻게 디비를 썼다.
//두레이도 좀 넣고.
//깃헙 소프트웨어 좀 넣고.
//데모 영상 필요. 결과에 대한 자세한 설명.
//사용한 디비들에 대한 설명, 피쳐 들에 대한 설명 , 피쳐가 몇% 사용됬는지 알 수 있을듯.

//장기투자자용 그들에게 필요한 정보들은 무엇인가.투자자 입장에서. 어떻게 사용했을때 좋을 것인지.

//앱에 대한 설명, 투자자입장에서 좋은이유, 만든 과정
//프로세스 있으면 좋을듯 어떻게 쓰면 좋을지. 내년에는 얼마 예측이니까 언제 팔면 좋겠다 이런거.
//투자자 입장에서 얼마가 남는다 이부분이 중요하다.
//5천만원 있을때 어느 주식을 사는게 가장 확률적으로 높은지 소팅 해서 보여주고 어느 시점에 파는게 좋을지 알려주는게 좋다.

import UIKit
import SwiftSocket
import Charts

public var priceGlobal : [Double] = []
public var valuationGlobal : [Double] = []
public var yearGlobal : [Double] = []

//show informations of application, each stock's graph,datas
class DetailViewController: UIViewController,UITableViewDataSource, ChartViewDelegate {

    @IBOutlet weak var chtChart: LineChartView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultRabel: UITextView!
    
    let host = "127.0.0.1"
    let port = 8080
    var client: TCPClient?
    var fname = "/Users/haseung-ik/Desktop/capstone1-master2/capstone1/linear/"
    var categories = ["Year      Realprice / Valuation"]
    var categoryObject : CategoryRow?
    var entname2 : String!
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //행을 추가할 수 있다 1,2,3,,,
        return priceGlobal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = "\(Int(yearGlobal[indexPath.row]))" + "       " +  "\(floor(priceGlobal[indexPath.row] * 1000)/1000)" + "  /  "  + "\(floor(valuationGlobal[indexPath.row] * 1000) / 1000)"
        
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
    
    
    // This variable will hold the data being passed from the First View Controller
    var receivedData = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        client = TCPClient(address: host, port: Int32(port))
        
        let endOfSentence = receivedData.firstIndex(of: "!")!
        let entname = String(receivedData[..<endOfSentence])
        let entcode = String(receivedData[receivedData.index(after: endOfSentence)...])
        
        entname2 = entname
        
        title = entname
        print(entname)
        fname = fname + entcode + ".csv"
        print(entcode)
        let csvObject = CsvController2.init(filename: fname)
        
        
        self.chtChart.delegate = self
        self.chtChart.gridBackgroundColor=UIColor.darkGray
        self.chtChart.noDataText = "No data provided"
        setChartData(csvObject:csvObject)
        
        tableView.dataSource = self
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var stockTitle: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    @IBAction func sendButtonAction(_ sender: UIButton) {
        print("button cliked")
        
        guard let client = client else { return }

        switch client.connect(timeout: 10) {
        case .success:
            print("success")
            appendToTextField(string: "Connected to host \(client.address)")
            if let response = sendRequest(string: "GET / HTTP/1.0\n\n", using: client) {
                appendToTextField(string: "Response: \(response)")
            }
        case .failure(let error):
            print("fail")
            appendToTextField(string: String(describing: error))
        }
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func sendRequest(string: String, using client: TCPClient) -> String? {
        appendToTextField(string: "Sending data ... ")
        
        switch client.send(string: string) {
        case .success:
            return readResponse(from: client)
        case .failure(let error):
            appendToTextField(string: String(describing: error))
            return nil
        }
    }
    
    private func readResponse(from client: TCPClient) -> String? {
        guard let response = client.read(1024*10) else { return nil }
        
        return String(bytes: response, encoding: .utf8)
    }
    
    private func appendToTextField(string: String) {
        print(string)
        textView.text = textView.text.appending("\n\(string)")
    }

    
    
    //btn
    
    @IBAction func btnButton(_ sender: Any) {
    }
    
    func setChartData(csvObject : CsvController2){
        
        // 1 - creating an array of data entries
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        var yVals2 : [ChartDataEntry] = [ChartDataEntry]()
        let year = csvObject.year
        var realPrice = csvObject.realPrice
        var valuation = csvObject.valuation
        
        yearGlobal = year
        priceGlobal = realPrice
        valuationGlobal = valuation
        
        if (Int(realPrice.last ?? 0) > Int(valuation.last ?? 0)) {
            resultRabel.text = entname2 + " 기업의 주가는\n떨어질 가능성이 있습니다."
        }else{
            resultRabel.text = entname2 + " 기업의 주가는\n오를 가능성이 있습니다."
        }
        
        categoryObject = CategoryRow.init(value : realPrice)
        
        for i in 0..<year.count {
            yVals1.append(ChartDataEntry(x: Double(Int(year[0])+i), y: realPrice[i]))
        }
        
        // 2 - create a data set with our array
        let set1: LineChartDataSet = LineChartDataSet(entries: yVals1, label: "실제 주가")
        set1.valueColors = [UIColor.white]
        set1.axisDependency = .left // Line will correlate with left axis values
        set1.setColor(UIColor.red.withAlphaComponent(0.5)) // our line's opacity is 50%
        set1.setCircleColor(UIColor.red) // our circle will be dark red
        set1.lineWidth = 2.0
        set1.circleRadius = 2.0 // the radius of the node circle
        set1.fillAlpha = 65 / 255.0
        set1.fillColor = UIColor.red
        set1.highlightColor = UIColor.white
        set1.drawCircleHoleEnabled = true
////////////////////////////////////
        for i in 0..<year.count {
            yVals2.append(ChartDataEntry(x: Double(Int(year[0])+i), y: valuation[i]))
        }
        
        // 2 - create a data set with our array
        let set2: LineChartDataSet = LineChartDataSet(entries: yVals2, label: "예상한 주가")
        set2.valueColors = [UIColor.white]
        set2.axisDependency = .left // Line will correlate with left axis values
        set2.setColor(UIColor.blue.withAlphaComponent(0.5)) // our line's opacity is 50%
        set2.setCircleColor(UIColor.blue) // our circle will be dark red
        set2.lineWidth = 2.0
        set2.circleRadius = 2.0 // the radius of the node circle
        set2.fillAlpha = 65 / 255.0
        set2.fillColor = UIColor.blue
        set2.highlightColor = UIColor.white
        set2.drawCircleHoleEnabled = true
        
        
        //3 - create an array to store our LineChartDataSets
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)
        dataSets.append(set2)
        
        //4 - pass our months in for our x-axis label value along with our dataSets
        let data: LineChartData = LineChartData(dataSets: dataSets)
        data.setValueTextColor(UIColor.white)
        
        //5 - finally set our data
        self.chtChart.data = data
        
        let xAxis = chtChart.xAxis
        let yleftAxis = chtChart.leftAxis
        let yrightAxis = chtChart.rightAxis
        xAxis.labelTextColor = UIColor.white
        yleftAxis.labelTextColor = UIColor.white
        yrightAxis.labelTextColor = UIColor.white
    }
    
    
}
