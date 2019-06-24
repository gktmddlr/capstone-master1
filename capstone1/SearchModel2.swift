//
//  SearchModel2.swift
//  capstone1
//
//  Created by 하승익 on 26/05/2019.
//  Copyright © 2019 하승익. All rights reserved.
//

import Foundation
import CSV

public class CsvController2{
    
    var year = [Double]()
    var valuation = [Double]()
    var realPrice = [Double]()
    
    init(filename : String){
        print(filename)
        let stream = InputStream(fileAtPath: filename)!
        let csv = try! CSVReader(stream: stream,hasHeaderRow: true)
        
        while let row = csv.next() {
            //needs encoding
            //print("\(row)")
            //print("\(csv["name"]!)")
            year.append(NSString(string: csv["time"]!).doubleValue)
            valuation.append(NSString(string: csv["valuation"]!).doubleValue)
            realPrice.append(NSString(string: csv["real_price"]!).doubleValue)
            
        }
        
        /*
         //code, name, class, beta , ratio.
         while csv.next() != nil {
         print("\(csv["name"]!)")   // => "1"
         //print("\(csv["name"]!)") // => "foo"
         }
         */
    }
    
    
    
}
