//
//  ViewController.swift
//  dragging demo
//
//  Created by Si Chen on 7/17/15.
//  Copyright © 2015 Si Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let label = UILabel(frame: CGRectMake(self.view.bounds.width / 2 - 100, self.view.bounds.height / 2 - 50, 200, 100))
        label.text = "Drag Me"
        label.textAlignment = NSTextAlignment.Center
        self.view.addSubview(label)
        let gesture = UIPanGestureRecognizer(target: self, action: Selector("dragged:"))
        label.addGestureRecognizer(gesture)
        label.userInteractionEnabled = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dragged(gesture:UIPanGestureRecognizer) {
        let translation = gesture.translationInView(self.view)
        let label = gesture.view!
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        if gesture.state == UIGestureRecognizerState.Ended {
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        }
        let xOffset = label.center.x - self.view.bounds.width / 2
        
        let rotation = CGAffineTransformMakeRotation(xOffset / self.view.bounds.width * 3.14)
        
        let stretch = CGAffineTransformScale(rotation, 1 - abs(xOffset) / self.view.bounds.width,  1-abs(xOffset) / self.view.bounds.width)
        label.transform = stretch
        
    }

}

