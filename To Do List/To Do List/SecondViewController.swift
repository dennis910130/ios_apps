//
//  SecondViewController.swift
//  To Do List
//
//  Created by ChenSi on 7/8/15.
//  Copyright (c) 2015 ChenSi. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var inputNewList: UITextField!

    @IBAction func addNew(sender: AnyObject) {
        var s = inputNewList.text
        list.append(s)
    }
    @IBAction func tabbed(sender: AnyObject) {
        self.inputNewList.resignFirstResponder()
    }
}

