//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by ChenSi on 7/10/15.
//  Copyright (c) 2015 ChenSi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var firstPlayer = true

    var firstPlayerArray = [Bool](count: 9, repeatedValue: false)
    
    var secondPlayerArray = [Bool](count: 9, repeatedValue: false)
    
    var gameFinished = false
    
    
    @IBAction func newGamePressed(sender: AnyObject) {
        
        firstPlayer = true
        firstPlayerArray = [Bool](count: 9, repeatedValue: false)
        secondPlayerArray = [Bool](count: 9, repeatedValue: false)
        gameFinished = false
        for view in self.view.subviews as [UIView] {
            if let btn = view as? UIButton {
                btn.setImage(UIImage(named:""), forState: .Normal)
            }
        }
        resultLabel.text = ""
        
    }
    @IBOutlet weak var resultLabel: UILabel!
    @IBAction func buttonPressed(sender: AnyObject) {
        if (!gameFinished) {
            if (firstPlayer) {
                sender.setImage(UIImage(named: "cross.png"), forState: .Normal)
                firstPlayer = false
                firstPlayerArray[sender.tag] = true
                if (hasWon(firstPlayerArray)) {
                    resultLabel.text = "cross won"
                    gameFinished = true
                }
                else if (firstPlayerArray.filter{$0 == true}.count == 5) {
                    resultLabel.text = "draw game"
                    gameFinished = true
                }
            }
            else {
                sender.setImage(UIImage(named: "circle.png"), forState: .Normal)
                firstPlayer = true
                secondPlayerArray[sender.tag] = true
                if (hasWon(secondPlayerArray)) {
                    resultLabel.text = "circle won"
                    gameFinished = true
                }
            }
        }
        
    }
    
    func hasWon(inputArray:[Bool]) -> Bool {
        for var index = 0; index < 3; index++ {
            let result = inputArray[index] & inputArray[index+3] & inputArray[index+6]
            if (result) {
                return true
            }
        }
        for var index = 0; index < 9; index+=3 {
            let result = inputArray[index] & inputArray[index+1] & inputArray[index+2]
            if (result) {
                return true
            }
        }
        if inputArray[0] & inputArray[4] & inputArray[8] | inputArray[2] & inputArray[4] & inputArray[6] {
            return true
        }
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

