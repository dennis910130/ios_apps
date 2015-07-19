//
//  SignUpViewController.swift
//  ParseStarterProject
//
//  Created by Si Chen on 7/18/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse


class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, gender"])
        graphRequest.startWithCompletionHandler({
            (connection, result, error) in
            if error != nil {
                print(error)
            } else if let result = result{
                print(result)
                PFUser.currentUser()?["gender"] = result["gender"]
                PFUser.currentUser()?["name"] = result["name"]
                PFUser.currentUser()?.save()
                let userId = result["id"] as! String
                let facebookProfileUrl = "http://graph.facebook.com/" + userId + "/picture?type=large"
                if let fbpicUrl = NSURL(string: facebookProfileUrl) {
                    if let data = NSData(contentsOfURL: fbpicUrl) {
                        self.imageView.image = UIImage(data: data)
                        let imageFile:PFFile = PFFile(data: data)
                        PFUser.currentUser()?["image"] = imageFile
                        PFUser.currentUser()?.save()
                    }
                }
            }
        })
        
        
    }

    @IBOutlet var imageView: UIImageView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUp(sender: AnyObject) {
        
        PFUser.currentUser()?["interestedInWomen"] = interestedInWomen.on
        PFUser.currentUser()?.save()
        
    }

    @IBOutlet var interestedInWomen: UISwitch!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
