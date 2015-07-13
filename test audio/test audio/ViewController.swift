//
//  ViewController.swift
//  test audio
//
//  Created by Si Chen on 7/13/15.
//  Copyright (c) 2015 Si Chen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var path = NSBundle.mainBundle().pathForResource("bach1", ofType: "mp3")
        var error : NSError? = nil
        player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path!), error: &error)
        player.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

