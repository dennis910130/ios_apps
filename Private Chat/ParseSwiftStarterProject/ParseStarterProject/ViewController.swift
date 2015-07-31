//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController,LGChatControllerDelegate {

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBAction func logInTouched(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(userId.text, password: password.text) { (user, error) -> Void in
            if user != nil {
                self.loggedIn()
            } else {
                if let errorString = error?.userInfo?["error"] as? String {
                    println(errorString)
                }
            }
        }
    }
    @IBOutlet var userId: UITextField!
    @IBOutlet var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
            loggedIn()
        }
    }
    func loggedIn() {
        println("\(PFUser.currentUser()!.username!) logged in")
        if let coupleId = PFUser.currentUser()?["coupleId"] {
            println("already have a couple Id")
            if let couple = PFUser.currentUser()?["couple"] {
                launchChatController()
            } else {
                var query = PFUser.query()
                query?.whereKey("coupleId", equalTo: coupleId)
                query?.whereKey("objectId", notEqualTo: PFUser.currentUser()!.objectId!)
                query?.findObjectsInBackgroundWithBlock({ (results, error) -> Void in
                    if error == nil {
                        if let results = results {
                            if results.count != 1 {
                                println("bug")
                            } else {
                                PFUser.currentUser()!["couple"] = results[0].objectId!
                                PFUser.currentUser()!.saveInBackgroundWithBlock({ (success, error) -> Void in
                                    if success {
                                        self.launchChatController()
                                    } else {
                                        println(error)
                                    }
                                })
                                
                            }
                        }
                    } else {
                        println("cannot find any user")
                    }
                })
            }
            
            //self.performSegueWithIdentifier("showChatting", sender: self)
        } else {
            self.performSegueWithIdentifier("firstTime", sender: self)
        }
    }
    func launchChatController() {
        let chatController = LGChatController()
        chatController.opponentImage = UIImage(named: "User")
        chatController.title = "Simple Chat"
        /*
        let helloWorld = LGChatMessage(content: "Hello World!", sentBy: .User)
        chatController.messages = [helloWorld]
        */
        chatController.delegate = self
        self.navigationController?.pushViewController(chatController, animated: true)
    }
    
    // MARK: LGChatControllerDelegate
    
    func chatController(chatController: LGChatController, didAddNewMessage message: LGChatMessage) {
        println("Did Add Message: \(message.content)")
    }
    
    func shouldChatController(chatController: LGChatController, addMessage message: LGChatMessage) -> Bool {
        /*
        Use this space to prevent sending a message, or to alter a message.  For example, you might want to hold a message until its successfully uploaded to a server.
        */
        return true
    }

    
}

