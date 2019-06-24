//
//  ViewController.swift
//  capstone1
//
//  Created by 하승익 on 10/04/2019.
//  Copyright © 2019 하승익. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn


class LoginViewController: UIViewController , GIDSignInUIDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view, typically from a nib.
        print("1")
        
        GIDSignIn.sharedInstance().uiDelegate = self
        print("2")
        // Uncomment to automatically sign in the user.
        GIDSignIn.sharedInstance().signInSilently()
        print("3")
        // TODO(developer) Configure the sign-in button look/feel
        
        
        // ...
    }
    
    func goToNextView() {
        print("called goToNextView")
        //DispatchQueue.main.async(){
            //self.performSegue(withIdentifier: "loginSegue", sender: self)
        //}
        //why not working , repeats this method....
        DispatchQueue.main.async(){
            self.performSegue(withIdentifier: "asd", sender: self)
        }
    }
    
    
    
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
}

