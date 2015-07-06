//
//  ViewController.swift
//  navigation_bar
//
//  Created by ChenSi on 6/14/15.
//  Copyright (c) 2015 ChenSi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = NSTimer()
    
    
    var time:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    @IBAction func resetButton(sender: AnyObject) {
        time = 0
        timeLabel.text = "0"

    }
    @IBAction func stopButton(sender: AnyObject) {
    }
    
    @IBAction func startButton(sender: AnyObject) {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("result"), userInfo: nil, repeats: true)
    }
    
    @IBOutlet weak var timeLabel: UILabel!

    
    func result() {
        
            time += 1
            timeLabel.text = String(time)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

