//
//  SearchModel.swift
//  capstone1
//
//  Created by 김동환 on 19/05/2019.
//  Copyright © 2019 하승익. All rights reserved.
//

import Foundation
import CSV

public class CsvController{
    
    var data = [String]()
    var data2 = [String]()
    
    init(filename : String){
        print(filename)
        let stream = InputStream(fileAtPath: filename)!
        let csv = try! CSVReader(stream: stream,hasHeaderRow: true)

        while let row = csv.next() {
            //needs encoding
            //print("\(row)")
            //print("\(csv["name"]!)")
            data.append(csv["name"]!)
            data2.append(csv["Code"]!)
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
