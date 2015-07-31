//
//  CoupleId.swift
//  ParseStarterProject
//
//  Created by Si Chen on 7/30/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class CoupleId: UIViewController {


    @IBOutlet var coupleId: UITextField!
    var result:PFUser!
    @IBAction func startChatting(sender: AnyObject) {
        if (count(coupleId.text as String) < 5) {
            showAlert("Couple Id", message: "Couple Id should contain more than 5 characters.")
        } else {
            var query = PFUser.query()
            query?.whereKey("coupleId", equalTo: coupleId.text)
            query?.findObjectsInBackgroundWithBlock({ (results, error) -> Void in
                if error != nil {
                    println(error)
                } else {
                    if let results = results {
                        if results.count == 0 {
                            let alert:UIAlertController = UIAlertController(title: "Couple Id", message: "\(self.coupleId.text) is a new couple id, do you want to sign up one with that?", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "Yes, please!", style: .Default, handler: {
                                (action) -> Void in
                                PFUser.currentUser()?["coupleId"] = self.coupleId.text
                                PFUser.currentUser()?.save()
                            }))
                            alert.addAction(UIAlertAction(title: "No", style: .Default, handler: nil))
                            self.presentViewController(alert, animated: true, completion: nil)
                        } else if results.count == 1 {
                            self.result = results[0] as! PFUser
                            if self.result.objectId! == PFUser.currentUser()?.objectId! {
                                self.showAlert("Couple Id", message: "You have alreay been associated with this Couple Id, please invite your better half to join private chat")
                            } else {
                                let alert:UIAlertController = UIAlertController(title: "Couple Id", message: "\(self.coupleId.text) is associated with \(self.result.username), is he(she) the right person?", preferredStyle: UIAlertControllerStyle.Alert)
                                alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: {
                                    (action) -> Void in
                                    PFUser.currentUser()?["coupleId"] = self.coupleId.text
                                    PFUser.currentUser()!["couple"] = self.result.objectId!
                                    self.result["couple"] = PFUser.currentUser()?.objectId!
                                    PFUser.currentUser()?.save()
                                }))
                                alert.addAction(UIAlertAction(title: "No, I will try use another one", style: .Default, handler: nil))
                                self.presentViewController(alert, animated: true, completion: nil)
                            }
                        } else {
                            self.showAlert("Couple Id", message: "\(self.coupleId.text) has already been used. Please try another one")
                        }
                    }
                }
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        println(PFUser.currentUser()?.password)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(title:String, message:String) {
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            //self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
