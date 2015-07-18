//
//  AddViewController.swift
//  ParseStarterProject
//
//  Created by Si Chen on 7/16/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse


class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var hasImage:Bool!
    var spinner = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        hasImage = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet var imageView: UIImageView!

    @IBAction func chooseImage(sender: AnyObject) {
        
        var imageChooser = UIImagePickerController()
        imageChooser.delegate = self
        var alert = UIAlertController(title: "Upload Image", message: "Where do you wanna get the image?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            imageChooser.sourceType = UIImagePickerControllerSourceType.Camera
            imageChooser.allowsEditing = false
            self.presentViewController(imageChooser, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Choose from file", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            imageChooser.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imageChooser.allowsEditing = false
            self.presentViewController(imageChooser, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = image
        hasImage = true
    }
    
    func showError(title:String!, message:String!) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
        }))
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
    
    @IBAction func uploadButton(sender: AnyObject) {
        
        if hasImage == false {
            self.showError("Upload Image", message: "You haven't upload an image")
        }
        else {
            spinner = UIActivityIndicatorView(frame: self.view.frame)
            spinner.center = self.view.center
            spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            spinner.hidesWhenStopped = true
            spinner.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
            self.view.addSubview(spinner)
            spinner.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var image = PFObject(className: "Images")
            image["message"] = word.text!
            image["name"] = PFUser.currentUser()?.username!
            image["userid"] = PFUser.currentUser()?.objectId!
            let imageData = UIImagePNGRepresentation(imageView.image)
            let imageFile = PFFile(name: "image.png", data: imageData)
            image["file"] = imageFile
            image.saveInBackgroundWithBlock { (success, error) -> Void in
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                self.spinner.stopAnimating()
                if error == nil {
                    self.showError("Upload Image", message: "Success")
                    self.imageView.image = UIImage(named: "empty.png")
                    self.hasImage = false
                    self.word.text = ""
                }
                else {
                    self.showError("Upload Image", message: "Failed")
                }
                
            }
        }
    }
    @IBOutlet var word: UITextField!
}
