//
//  ViewController.swift
//  animation
//
//  Created by ChenSi on 7/9/15.
//  Copyright (c) 2015 ChenSi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var timer = NSTimer()
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }
    var count:Int = 0
    
    func nextFunc() {
        count = (count + 1) % 5
        imageView.image = UIImage(named: "\(count+1).png")
    }
    
    var playing = false
    
    @IBAction func nextButton(sender: AnyObject) {
        if playing == false {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("nextFunc"), userInfo: nil, repeats: true)
            playing = true
        }
        else {
            timer.invalidate()
            playing = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

