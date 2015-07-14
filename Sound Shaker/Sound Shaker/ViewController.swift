//
//  ViewController.swift
//  Sound Shaker
//
//  Created by Si Chen on 7/13/15.
//  Copyright (c) 2015 Si Chen. All rights reserved.
//

import UIKit
import AVFoundation
import MapKit

class ViewController: UIViewController {
    var paths = [String]()
    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let filemanager:NSFileManager = NSFileManager()
        let files = filemanager.enumeratorAtPath("/Users/sichen/Documents/github/ios_apps/Sound Shaker/")
        while let file = files?.nextObject() as? String {
            if file.lastPathComponent.pathExtension == "mp3" {
                paths.append(file.lastPathComponent.stringByDeletingPathExtension)
            }
        }
        var annotationPoint = MKAnnotation
        
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if event.subtype == UIEventSubtype.MotionShake {
            let num = Int(arc4random_uniform(UInt32(paths.count)))
            var path = NSBundle.mainBundle().pathForResource(paths[num], ofType: "mp3")
            var error:NSError? = nil
            player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path!), error: &error)
            player.play()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

