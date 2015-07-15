//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

