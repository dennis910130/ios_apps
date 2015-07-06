//
//  ViewController.swift
//  My Stopwatch
//
//  Created by ChenSi on 6/16/15.
//  Copyright (c) 2015 ChenSi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    var timer = NSTimer()
    
    var startTime = NSTimeInterval()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        

        
    }
    

    var baseTime:NSTimeInterval = 0
    var interval:NSTimeInterval = 0
    
    var running = false
    
    @IBAction func resetButton(sender: AnyObject) {
        if (!running) {
            baseTime = 0
            timeLabel.text = "00:00:00:000"
        }
    }
    
    @IBAction func stopButton(sender: AnyObject) {
        if (running) {
            timer.invalidate()
            baseTime += interval
            running = false
        }
    }
    
    @IBAction func startButton(sender: AnyObject) {
        if (!running) {
            startTime = NSDate.timeIntervalSinceReferenceDate()

            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
            running = true
        }
    }
    func updateTime() {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        interval = currentTime - startTime
        var string = stringFromTimeInterval(interval + baseTime)
        timeLabel.text = string
        
    }
    
    func stringFromTimeInterval(interval:NSTimeInterval) -> String {
        var time = interval
        var ms = Int((time % 1) * 1000)
        var sec = Int(time % 60)
        var min = Int((time / 60) % 60)
        var hour = Int(time / 3600)
        return String(format: "%0.2d:%0.2d:%0.2d:%0.3d", hour, min, sec, ms)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

