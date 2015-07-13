//
//  AddViewController.swift
//  Memorable Places
//
//  Created by ChenSi on 7/11/15.
//  Copyright (c) 2015 ChenSi. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var memoInput: UITextField!
    @IBOutlet weak var nameInput: UITextField!
    @IBAction func tapped(sender: AnyObject) {
        memoInput.resignFirstResponder()
        nameInput.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func okButton(sender: AnyObject) {
        let newPlace = place(location: realCoord, name: nameInput.text, memo: memoInput.text)
        places.append(newPlace)
        selected = places.count - 1
        let mapViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
