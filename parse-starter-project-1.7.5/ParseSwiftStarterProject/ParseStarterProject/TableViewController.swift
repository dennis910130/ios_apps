//
//  TableViewController.swift
//  ParseStarterProject
//
//  Created by Si Chen on 7/15/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse


struct Friend {
    var userName:String
    var userId:String
    var isFollowing:Bool
}

class TableViewController: UITableViewController {
    
    var friends = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        friends.removeAll(keepCapacity: true)
        var query = PFUser.query()!
        query.whereKey("username", notEqualTo: PFUser.currentUser()!.username!)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let users = objects {
                for user in users {
                    var query = PFQuery(className: "Followers")
                    query.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
                    query.whereKey("following", equalTo: user.objectId!!)
                    query.findObjectsInBackgroundWithBlock({ (results, error) -> Void in
                        if let results = results {
                            var friend:Friend?
                            if results.count > 0 {
                                friend = Friend(userName: user.username!!, userId: user.objectId!!, isFollowing: true)
                            } else {
                                friend = Friend(userName: user.username!!, userId: user.objectId!!, isFollowing: false)
                            }
                            self.friends.append(friend!)
                            self.tableView.reloadData()
                        }
                    })
    
                }
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return friends.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        if friends.count > 0 {
            cell.textLabel?.text = friends[indexPath.row].userName
            if friends[indexPath.row].isFollowing {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            // Configure the cell...
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell?.accessoryType == UITableViewCellAccessoryType.Checkmark {
            var alert = UIAlertController(title: "Unfollowing", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                //remove
                var query = PFQuery(className: "Followers")
                query.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
                query.whereKey("following", equalTo: self.friends[indexPath.row].userId)
                query.findObjectsInBackgroundWithBlock({ (results:[AnyObject]?, error) -> Void in
                    if let results = results {
                        for result in results {
                            result.deleteInBackgroundWithBlock({
                                (success, error) in
                                cell?.accessoryType = UITableViewCellAccessoryType.None
                            })
                        }
                    }
                })
                //self.dismissViewControllerAnimated(true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                //self.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            var following = PFObject(className: "Followers")
            following["following"] = friends[indexPath.row].userId
            following["follower"] = PFUser.currentUser()?.objectId
            following.saveInBackground()
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
