//
//  ViewController.swift
//  Storing Images
//
//  Created by Si Chen on 7/14/15.
//  Copyright (c) 2015 Si Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSURL(string: "http://soccer-tricks.com/wp-content/uploads/2014/10/cristiano-ronaldo1.jpg")!
        let urlRequest = NSURLRequest(URL: url)
    
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
            response, data, error in
            
            if error != nil {
                
                println("There was an error!")
                
            } else {
                
                let image = UIImage(data: data)
                //self.imageView.image = image
                var documentDirectory:String? = nil
                var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                if paths.count > 0 {
                    
                    documentDirectory = paths[0] as? String
                    
                    var savePath = documentDirectory! + "/cr7.jpg"
                    println(savePath)
                    NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
                    
                    self.imageView.image = UIImage(named: savePath)
                } else {
                    
                    println("no path")
                    
                }
                
            }
            
            
        })
        */
        var documentDirectory:String? = nil
        var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        if paths.count > 0 {
            
            documentDirectory = paths[0] as? String
            
            var savePath = documentDirectory! + "/cr7.jpg"
            println(savePath)
            
            self.imageView.image = UIImage(named: savePath)
        } else {
            
            println("no path")
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

