//
//  feedTable.swift
//  ParseStarterProject
//
//  Created by Si Chen on 7/16/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

struct Post {
    var message:String
    var username:String
    var imageFile:PFFile
}

class FeedTable: UITableViewController {

    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posts.removeAll(keepCapacity: true)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        var getFollowingUsersQuery = PFQuery(className: "Followers")
        getFollowingUsersQuery.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
        getFollowingUsersQuery.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            if let results = results {
                for result in results {
                    var query = PFQuery(className: "Images")
                    query.whereKey("userid", equalTo: result["following"] as! String)
                    query.findObjectsInBackgroundWithBlock({ (images, error) -> Void in
                        if let images = images {
                            for image in images {
                                
                                var newPost = Post(message: image["message"] as! String, username: image["name"] as! String, imageFile: image["file"] as! PFFile)
                                self.posts.append(newPost)
                                self.tableView.reloadData()
                            }
                        }
                    })
                }
            } else {
                println("error")
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
        return posts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedCell", forIndexPath: indexPath) as! Cell
        posts[indexPath.row].imageFile.getDataInBackgroundWithBlock { (data, error) -> Void in
            if let downloadImage = UIImage(data: data!) {
                cell.imagePost.image = downloadImage
            }
        }
        // Configure the cell...
        cell.imagePost.image = UIImage(named: "empty.png")
        cell.userLabel.text = posts[indexPath.row].username
        cell.messageLabel.text = posts[indexPath.row].message
        
        return cell
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
