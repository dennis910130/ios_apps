//
//  ViewController.swift
//  tableViews
//
//  Created by ChenSi on 7/6/15.
//  Copyright (c) 2015 ChenSi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var cellContent = ["a", "b", "c"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel.text = cellContent[indexPath.row]
        return cell
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

