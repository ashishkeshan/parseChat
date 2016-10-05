//
//  ChatViewController.swift
//  Parse Chat Client
//
//  Created by Ashish Keshan on 9/22/16.
//  Copyright © 2016 Ashish Keshan. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var mtable: UITableView!
    @IBOutlet var messageField: UITextField!
    var message = PFObject(className:"Message_fbuJuly2016")
    var messagesArray: NSMutableArray = [""]
    var usersArray: NSMutableArray = [""]
    @IBAction func send(sender: AnyObject) {
        
        message["text"] = messageField.text
        message["user"] = PFUser.currentUser()
        
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print(self.messageField.text!)
                // The object has been saved.
            } else {
                print(error)
                // There was a problem, check error.description
            }
        }
        onTimer()
        mtable.reloadData()

    }
    override func viewDidLoad(){
        super.viewDidLoad()
        mtable.dataSource = self
        mtable.delegate = self
        mtable.estimatedRowHeight = 100
        mtable.rowHeight = UITableViewAutomaticDimension
        onTimer()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func queryMessage(){
        var query = PFQuery(className:"Message_fbuJuly2016")
        query.orderByDescending("createdAt")
        query.includeKey("user")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) messages.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        //print(object["text"])
                        self.messagesArray.addObject(object["text"])
                        if let usr = object["user"] as? PFUser{
                            self.usersArray.addObject(usr.username!)
                            //print(usr.username!)
                        }
                        else{
                            object["user"] = "anonymous"
                            self.usersArray.addObject(object["user"])                        }
                        
                        
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        mtable.reloadData()

    }
    
    func onTimer(){
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.queryMessage), userInfo: nil, repeats: true)
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Message", forIndexPath: indexPath) as! Message
        
        cell.sentMessage.text = messagesArray[indexPath.row] as! String
        cell.username.text = usersArray[indexPath.row] as! String 
       // print("array filled")
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }

    
   
}
