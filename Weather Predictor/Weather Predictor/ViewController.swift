//
//  ViewController.swift
//  Weather Predictor
//
//  Created by ChenSi on 7/9/15.
//  Copyright (c) 2015 ChenSi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputText: UITextField!
    
    
    @IBOutlet var tappedButton: UITapGestureRecognizer!
    
    @IBOutlet weak var outputLabel: UILabel!
    
    
    func showError() {
        dispatch_async(dispatch_get_main_queue()) {
            self.outputLabel.text = "Sorry we cannot find the weather for " + self.inputText.text
        }
        
    }
    
    @IBAction func goButton(sender: AnyObject) {
        let urlString = "http://www.weather-forecast.com/locations/" + inputText.text.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest"
        
        let url = NSURL(string: urlString)
        
        if url != nil {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
                (data, response, error) in
                if error == nil {
                    
                    var htmlString = NSString(data: data, encoding: NSUTF8StringEncoding)!
                    var urlContentArray = htmlString.componentsSeparatedByString("<span class=\"phrase\">")
                    if (urlContentArray.count < 2) {
                        self.showError()
                    }
                    else {
                        var message = urlContentArray[1].componentsSeparatedByString("</span>") as [String]
                        
                        if (message.count == 0) {
                            self.showError()
                        }
                        else {
                            dispatch_async(dispatch_get_main_queue()) {
                                self.outputLabel.text = message[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                            }
                            
                        }
                    }

                }
                else {
                    self.showError()
                }
            }
            task.resume()
        }
        else {
            showError()
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        outputLabel.text = "Information will display here."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

