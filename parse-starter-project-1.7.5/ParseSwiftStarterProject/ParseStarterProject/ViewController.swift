//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

