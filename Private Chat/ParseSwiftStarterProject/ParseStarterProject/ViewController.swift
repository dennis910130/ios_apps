//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBAction func logInTouched(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(coupleId.text, password: password.text) { (user, error) -> Void in
            if user != nil {
                println("logged in");
            } else {
                if let errorString = error?.userInfo?["error"] as? String {
                    println(errorString)
                }
            }
        }
    }
    @IBOutlet var coupleId: UITextField!
    @IBOutlet var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

