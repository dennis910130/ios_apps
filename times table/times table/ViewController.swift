//
//  ViewController.swift
//  times table
//
//  Created by ChenSi on 7/7/15.
//  Copyright (c) 2015 ChenSi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        let time = Int(sliderValue.value * 20)
        cell.textLabel.text = String(time * indexPath.row)
        return cell
    }
    
    @IBOutlet weak var sliderValue: UISlider!
    @IBAction func slider(sender: AnyObject) {
        table.reloadData()
    }
    
    

}

