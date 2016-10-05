//
//  LoginViewController.swift
//  Parse Chat Client
//
//  Created by Ashish Keshan on 9/22/16.
//  Copyright © 2016 Ashish Keshan. All rights reserved.
//

import UIKit
import Parse
class LoginViewController: UIViewController {
    
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    var account = PFObject(className:"credentials")
    
    
    @IBAction func signup(sender: AnyObject) {
        let alertController = UIAlertController(title: "Error", message: "Please fill in both fields", preferredStyle: .Alert)
        
        var user = PFUser()

        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        
        // create a cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // handle cancel response here. Doing nothing will dismiss the view.
        }
        // add the cancel action to the alertController
        alertController.addAction(cancelAction)
        
        
        
        
        if( emailField.text == "" || passwordField.text == "" ){
                    }
        else{
            
            user.username = emailField.text
            user.password = passwordField.text
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if let error = error {
                    self.presentViewController(alertController, animated: true) {
                        // optional code for what happens after the alert controller has finished presenting
                    }
                    let errorString = error.userInfo["error"] as? NSString
                    // Show the errorString somewhere and let the user try again.
                } else {
                    print("success")
                    // Hooray! Let them use the app now.
                }
            }
        }
    }
    
    
    @IBAction func login(sender: AnyObject) {
        //let password = account["password"] as! String
        //let email = account["email"] as! String
        
        let alertController = UIAlertController(title: "Error", message: "Incorrect Credentials", preferredStyle: .Alert)
        
        
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        
        // create a cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // handle cancel response here. Doing nothing will dismiss the view.
        }
        // add the cancel action to the alertController
        alertController.addAction(cancelAction)
        
        PFUser.logInWithUsernameInBackground(emailField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("LogInSuccess", sender: self)
                }
            } else {
                self.presentViewController(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
                }
            }
        }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
  
}
