//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var signUpMode = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*
        var product = PFObject(className: "Products")
        product["name"] = "Pasta"
        product["description"] = "Alfredo"
        product["price"] = 4.99
        product.saveInBackgroundWithBlock({
            (success, error) in
            if (success == true) {
                
                println("\(product.objectId)")
                
            } else {
                println("Failed.")
                println(error)
            }
        })
        */
        /*
        var query = PFQuery(className: "Products")
        query.getObjectInBackgroundWithId("FHUxik3PHc", block: { (object:PFObject?, error:NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let product = object{
                product["description"] = "Chiken"
                product["price"] = 5.99
                product.saveInBackground()
            }
        })
        */
        
        
        
    }
    
    /*
    @IBAction func restore(sender: AnyObject) {
        
        activityIndicator.stopAnimating()
        //UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
    }
    
    @IBAction func createAlert(sender: AnyObject) {
        
        var alert = UIAlertController(title: "Hello", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    @IBAction func pause(sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        //UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        println("Image Selected.")
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        importedImage.image = image
        
    }
    
    
        @IBAction func importButton(sender: AnyObject) {
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
        
    }


    @IBOutlet var importedImage: UIImageView!
    */
    @IBOutlet var usernameInput: UITextField!
    
    func showAlert(title:String, message:String) {
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBOutlet var topButton: UIButton!

    @IBOutlet var leftLabel: UILabel!
    @IBOutlet var bottomButton: UIButton!
    @IBAction func signUp(sender: AnyObject) {
        
        self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        if signUpMode {
        
            var user = PFUser()
            user.password = passwordInput.text
            user.username = usernameInput.text
            user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                if let error = error {
                    if let errorString = error.userInfo?["error"] as? String {
                        self.showAlert("Error in SignUp", message: errorString)
                    } else {
                        self.showAlert("Error in SignUp", message: "Please try again!")
                    }
                    
                    
                } else {
                    
                    println("successfully signed up")
                    
                
                
                }
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                self.activityIndicator.stopAnimating()
            })
        } else {
            PFUser.logInWithUsernameInBackground(usernameInput.text, password: passwordInput.text) {
                (user, error) in
                if user != nil {
                    println("Welcome back \(user!.username!)")
                } else {
                    if let errorString = error?.userInfo?["error"] as? String {
                        self.showAlert("Error In LogIn", message: errorString)
                    } else {
                        self.showAlert("Error In LogIn", message: "Please try again!")
                    }
                }
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                self.activityIndicator.stopAnimating()
            }

        }
        
    }
    
    @IBAction func logIn(sender: AnyObject) {
        self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        if signUpMode == true {
            topButton.setTitle("Log In", forState: UIControlState.Normal)
            bottomButton.setTitle("Sign Up", forState: UIControlState.Normal)
            leftLabel.text = "Not Registered?"
            signUpMode = false
        } else {
            topButton.setTitle("Sign Up", forState: UIControlState.Normal)
            bottomButton.setTitle("Log In", forState: UIControlState.Normal)
            leftLabel.text = "Already Registered?"
            signUpMode = true
        }
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        self.activityIndicator.stopAnimating()
        
        
    }
    @IBOutlet var passwordInput: UITextField!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

