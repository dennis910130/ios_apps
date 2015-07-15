//
//  DetailViewController.swift
//  Blog Reader
//
//  Created by Si Chen on 7/14/15.
//  Copyright (c) 2015 Si Chen. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    @IBOutlet var webView: UIWebView!
    func configureView() {
        // Update the user interface for the detail item.
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        var request = NSFetchRequest(entityName: "Post")
        request.returnsObjectsAsFaults = false
        var results = context.executeFetchRequest(request, error: nil)
        
        webView.loadHTMLString(results![selectedRow].valueForKey("content") as! String, baseURL: nil)
        self.title = results![selectedRow].valueForKey("title") as? String
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

