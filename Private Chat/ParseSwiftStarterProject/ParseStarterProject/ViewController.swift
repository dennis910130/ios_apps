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
        PFUser.logInWithUsernameInBackground(userId.text, password: password.text) { (user, error) -> Void in
            if user != nil {
                self.loggedIn()
            } else {
                if let errorString = error?.userInfo?["error"] as? String {
                    println(errorString)
                }
            }
        }
    }
    @IBOutlet var userId: UITextField!
    @IBOutlet var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
            loggedIn()
        }
    }
    func loggedIn() {
        println("\(PFUser.currentUser()!.username!) logged in")
        if let coupleId = PFUser.currentUser()?["coupleId"] {
            println("already have a couple Id")
        } else {
            self.performSegueWithIdentifier("firstTime", sender: self)
        }
    }
    
}

