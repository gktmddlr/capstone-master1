//
//  TabBarViewController1.swift
//  capstone1
//
//  Created by 김동환 on 07/05/2019.
//  Copyright © 2019 하승익. All rights reserved.
//

import UIKit
import Firebase
import SwiftSocket

let delegate = UIApplication.shared.delegate as! AppDelegate

class TabBarViewController1: UITabBarController {
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* db part */
        db = Firestore.firestore()
        
        /*
         //not using db
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "first": "Alan",
            "middle": "Mathison",
            "last": "Turing",
            "born": 1912
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        */
        
        
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}



