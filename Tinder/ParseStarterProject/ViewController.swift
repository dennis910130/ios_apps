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
        let permissions = ["public_profile"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            (user: PFUser?, error: NSError?) -> Void in
            
            if let error = error {
                print(error)
            } else {
                if let user = user {
                    print(user)
                    self.performSegueWithIdentifier("showLogin", sender: self)
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
            performSegueWithIdentifier("showLogin", sender: self)
            print("logged in")
        }
        
    }
}

