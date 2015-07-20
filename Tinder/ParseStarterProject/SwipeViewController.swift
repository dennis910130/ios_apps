//
//  SwipeViewController.swift
//  ParseStarterProject
//
//  Created by Si Chen on 7/18/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class SwipeViewController: UIViewController {
    var currentId:String!
    var imageCenter:CGPoint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let gesture = UIPanGestureRecognizer(target: self, action: Selector("dragged:"))
        imageView.addGestureRecognizer(gesture)
        imageView.userInteractionEnabled = true
        imageView.center.x = self.view.bounds.width / 2
        imageCenter = imageView.center as! CGPoint
        
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error:NSError?) in
            if let geoPoint = geoPoint {
                PFUser.currentUser()!["location"] = geoPoint
                PFUser.currentUser()!.save()
                self.updateImage()
            }
        }
        

    }
    
    func updateImage() {
        var query = PFUser.query()
        
        if let latitude = PFUser.currentUser()!["location"]!.latitude {
            if let longitude = PFUser.currentUser()!["location"]!.longitude {
                //query!.whereKey("location", withinGeoBoxFromSouthwest: PFGeoPoint(latitude:latitude - 5, longitude:longitude - 5), toNortheast: PFGeoPoint(latitude:latitude + 5, longitude: longitude + 5))
            }
            
        }
        
        if PFUser.currentUser()!["interestedInWomen"] as! Bool == true {
            query!.whereKey("gender", equalTo: "female")
            print("female")
        } else {
            query!.whereKey("gender", equalTo: "male")
            print("male")
        }
        
        let isFemale = PFUser.currentUser()!["gender"] as! String == "female"
        print(isFemale)
        query!.whereKey("interestedInWomen", equalTo: isFemale)
        query!.limit = 1
        
        var ignoredUsers = [""]
        
        if let rejectedUsers = PFUser.currentUser()!["rejected"]{
            ignoredUsers += rejectedUsers as! Array
        }
        
        if let acceptedUsers = PFUser.currentUser()!["accepted"]{
            ignoredUsers += acceptedUsers as! Array
        }
        
        query!.whereKey("objectId", notContainedIn: ignoredUsers as! Array)

        
        query!.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error:NSError?) in
            print("in")
            if error != nil {
                print(error)
            } else {
                if let objects = objects as? [PFObject]{
                    if objects.count == 0 {
                        self.imageView.image = UIImage(named: "Not_available.jpg")
                    } else {
                        for object in objects {
                            let imageFile = object["image"] as! PFFile
                            imageFile.getDataInBackgroundWithBlock {
                                (imageData: NSData?, error:NSError?) in
                                
                                if error != nil {
                                    print(error)
                                } else {
                                    if let imageData = imageData {
                                        self.imageView.image = UIImage(data: imageData)
                                        self.currentId = object.objectId! as! String
                                                                        }
                                }
                                
                            }
                        }
                    }
                } else {
                    print("cannot find anything")
                }
            }
        }

    }
    
    
    func dragged(gesture:UIPanGestureRecognizer) {
        let translation = gesture.translationInView(self.view)
        let label = gesture.view! as! UIImageView
        label.center = CGPoint(x: imageCenter.x + translation.x, y: imageCenter.y + translation.y)
        if gesture.state == UIGestureRecognizerState.Ended {
            label.center = CGPoint(x: imageCenter.x, y: imageCenter.y)
            if (imageCenter.x + translation.x < 100) {
                PFUser.currentUser()!.addUniqueObjectsFromArray([self.currentId], forKey: "rejected")
                PFUser.currentUser()!.save()
                updateImage()
            } else if (imageCenter.x + translation.x > self.view.bounds.width - 100) {
                PFUser.currentUser()!.addUniqueObjectsFromArray([self.currentId], forKey: "accepted")
                PFUser.currentUser()!.save()
                updateImage()
            } else {
                print("still hesitating")
            }
        }
        let xOffset = label.center.x - imageCenter.x
        let rotation = CGAffineTransformMakeRotation(xOffset / self.view.bounds.width * 2)

        let stretch = CGAffineTransformScale(rotation, 1 - abs(xOffset) / self.view.bounds.width,  1-abs(xOffset) / self.view.bounds.width)
        label.transform = stretch
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOut(sender: AnyObject) {
        
    }

    @IBOutlet var imageView: UIImageView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "logOutSegue" {
            PFUser.logOut()
        }
    }
    
}
