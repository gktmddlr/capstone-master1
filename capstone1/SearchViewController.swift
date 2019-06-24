//
//  ViewController.swift
//  capstone1
//
//  Created by 하승익 on 10/04/2019.
//  Copyright © 2019 하승익. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate{
    
    let csvObject = CsvController.init(filename: "/Users/haseung-ik/Desktop/capstone1-master2/capstone1/allstock_info.csv")

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var stockGraphImage: UIButton!
   
    let mainChart : UIImage = UIImage(named: "mainchart")!
  
    
    var data = ["s,s"]
    var data2 = ["s"];
    
    var filteredData: [String]!
    var filteredData2: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        data = csvObject.data
        data2 = csvObject.data2
        filteredData = data
        filteredData2 = data2
        
        tableView.backgroundColor = .clear
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print("1")
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // print("2")
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        //print("3")
        cell.textLabel?.text = filteredData[indexPath.row]
        
        cell.backgroundColor = tableView.backgroundColor
        cell.contentView.backgroundColor = tableView.backgroundColor
        
        if(searchBar.text! == "")
        {
           cell.isHidden = true
        }
        else{
            cell.isHidden = false
        }
        
        return cell
    }
    
    
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){

        filteredData = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
    
        tableView.reloadData()
    }
    
    ///    Detail view
    
    // ...
    
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checklist = filteredData[indexPath.row]
        let checklist2 = filteredData2[data.index(of: checklist) ?? 0]
        let checklist3 = checklist + "!" + checklist2
        // Segue to the second view controller
        self.performSegue(withIdentifier: "segueToDetailView", sender: checklist3)
    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get a reference to the second view controller
        let DetailViewController = segue.destination as! DetailViewController
        // set a variable in the second view controller with the data to pass
        DetailViewController.receivedData = sender as! String
    
    }

}
