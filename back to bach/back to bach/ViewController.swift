//
//  ViewController.swift
//  back to bach
//
//  Created by Si Chen on 7/12/15.
//  Copyright (c) 2015 Si Chen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var path = NSBundle.mainBundle().pathForResource("zhaozhao1", ofType: "mp3")
        println(path)
        var error:NSError? = nil
        audioPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path!), error: &error)
        if (error != nil) {
            println(error)
        }
    }

    
    @IBAction func stopPressed(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        playButton.setTitle("PLAY", forState: .Normal)
    }
    @IBAction func playPressed(sender: AnyObject) {
        if playButton.titleLabel!.text! == "PLAY" {
            audioPlayer.play()
            playButton.setTitle("PAUSE", forState: .Normal)
        }
        else {
            audioPlayer.pause()
            playButton.setTitle("PLAY", forState: .Normal)
        }
        
    }
    @IBOutlet var playButton: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

