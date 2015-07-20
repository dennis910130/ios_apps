//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.


        /*
        let push = PFPush()
        push.setChannel("Giants")
        push.setMessage("The Giants just scored!")
        push.sendPushInBackground()
        */
    }

    
    @IBAction func loginWithFB(sender: AnyObject) {
        let permissions = ["public_profile", "email"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            (user: PFUser?, error: NSError?) -> Void in
            
            if let error = error {
                print(error)
            } else {
                if let user = user {
                    if user["interestedInWomen"] == nil {
                        self.performSegueWithIdentifier("showLogin", sender: self)
                    } else {
                        self.performSegueWithIdentifier("showSwipe", sender: self)
                    }
                }
            }
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        if let username = PFUser.currentUser()?.username {
            if PFUser.currentUser()?["interestedInWomen"] == nil {
                performSegueWithIdentifier("showLogin", sender: self)
            } else {
                performSegueWithIdentifier("showSwipe", sender: self)

            }
        }
        
    }
}

