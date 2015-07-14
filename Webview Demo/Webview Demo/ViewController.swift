//
//  ViewController.swift
//  Webview Demo
//
//  Created by Si Chen on 7/14/15.
//  Copyright (c) 2015 Si Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var url = NSURL(string: "http://www.creditintro.com")!
        var request = NSURLRequest(URL: url)
        webView.loadRequest(request)
        
    }

    @IBOutlet var webView: UIWebView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

