//
//  ViewController.swift
//  Sound Shaker
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
        let filemanager:NSFileManager = NSFileManager()
        let files = filemanager.enumeratorAtPath("/Users/sichen/Documents/github/ios_apps/Sound Shaker/")
        while let file = files?.nextObject() {
            println(file)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

